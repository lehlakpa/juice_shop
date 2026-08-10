import 'package:coffee_shop/modals/drinks_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final DrinksModel item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  bool isFavorite = true;
  late AnimationController _animController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<double>(begin: 60, end: 0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final size = MediaQuery.of(context).size;
    final bottomCardHeight = size.height * 0.54;
    final imageAreaBottom = bottomCardHeight - 30;

    return Scaffold(
      backgroundColor: item.topBackgroundColor,
      body: Stack(
        children: [
          // ── TOP COLORED BACKGROUND ──────────────────────────────────────
          Positioned.fill(child: Container(color: item.topBackgroundColor)),

          // ── BOTTOM CARD ────────────────────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Opacity(opacity: _fadeAnimation.value, child: child),
                );
              },
              child: Container(
                height: bottomCardHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: item.bottomBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(44),
                    topRight: Radius.circular(44),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 24,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Title + Heart ──────────────────────────────
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${item.title} Shakes',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: item.textColor,
                                  height: 1.2,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () =>
                                  setState(() => isFavorite = !isFavorite),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: isFavorite
                                      ? const Color(0xFFBF2930)
                                      : Colors.white24,
                                  shape: BoxShape.circle,
                                  boxShadow: isFavorite
                                      ? [
                                          BoxShadow(
                                            color: const Color(
                                              0xFFBF2930,
                                            ).withValues(alpha: 0.4),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // ── Star Rating ────────────────────────────────
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              final filled = index < item.rating.floor();
                              final half =
                                  !filled &&
                                  index < item.rating &&
                                  item.rating - index >= 0.5;
                              return Icon(
                                filled
                                    ? Icons.star_rounded
                                    : half
                                    ? Icons.star_half_rounded
                                    : Icons.star_outline_rounded,
                                color: Colors.amber,
                                size: 24,
                              );
                            }),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${item.rating.toInt()}/5',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // ── Price ──────────────────────────────────────
                        Text(
                          'Price \$${item.price.toInt()}',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: item.textColor,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ── Quantity Selector ──────────────────────────
                        Row(
                          children: [
                            _CircleButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              color: item.textColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                quantity.toString().padLeft(2, '0'),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: item.textColor,
                                ),
                              ),
                            ),
                            _CircleButton(
                              icon: Icons.add,
                              onTap: () => setState(() => quantity++),
                              color: item.textColor,
                            ),
                          ],
                        ),

                        const Spacer(),

                        // ── Order Now Button ───────────────────────────
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: item.buttonColor,
                              foregroundColor: item.textColor,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                            child: Text(
                              'Order Now',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: item.textColor,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── HERO DRINK IMAGE ───────────────────────────────────────────
          Positioned(
            top: size.height * 0.03,
            bottom: imageAreaBottom,
            left: 16,
            right: 16,
            child: Hero(
              tag: 'drink_${item.title}',
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.local_drink_rounded,
                  size: 130,
                  color: Colors.white54,
                ),
              ),
            ),
          ),

          // ── BACK BUTTON ────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.30),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── CIRCULAR QUANTITY BUTTON ──────────────────────────────────────────────────
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
