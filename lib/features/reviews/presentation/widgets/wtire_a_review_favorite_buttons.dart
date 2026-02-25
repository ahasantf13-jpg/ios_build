import 'package:beautygm/core/widgets/custom_scaffold_messenger.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:beautygm/features/favorites/data/models/clinic_hive_model.dart';
import 'package:beautygm/features/favorites/data/services/favorites_services.dart';
import 'package:beautygm/features/reviews/presentation/helpers/add_review_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WtireAReviewFavoriteButtons extends StatefulWidget {
  final ClinicEntity clinic;

  const WtireAReviewFavoriteButtons({super.key, required this.clinic});

  @override
  State<WtireAReviewFavoriteButtons> createState() =>
      _WtireAReviewFavoriteButtonsState();
}

class _WtireAReviewFavoriteButtonsState
    extends State<WtireAReviewFavoriteButtons> {
  final FavoritesService favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              showWriteReviewBottomSheet(
                context,
                clinic: widget.clinic,
                controller: TextEditingController(),
              );
            },
            child: const Text("Write a review"),
          ),
        ),
        SizedBox(width: 8.w),
        ValueListenableBuilder<List<ClinicHiveModel>>(
          valueListenable: favoritesService.favoritesNotifier,
          builder: (context, favorites, _) {
            final isFav =
                favorites.any((c) => c.clinicId == widget.clinic.clinicId);

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFD0D5DD)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  if (isFav) {
                    await favoritesService
                        .removeFavorite(widget.clinic.clinicId);
                    CustomScaffoldMessenger().showFail(
                      "Clinic was removed from favorites!",
                    );
                  } else {
                    await favoritesService.addFavorite(
                      ClinicHiveModel(
                        clinicId: widget.clinic.clinicId,
                        clinicName: widget.clinic.clinicName,
                        clinicLogoUrl: widget.clinic.clinicLogoUrl,
                        clinicDescription: widget.clinic.clinicDescription,
                        clinicLocation: widget.clinic.clinicLocation,
                        clinicAverageRating:
                            widget.clinic.clinicAverageRating.toDouble(),
                        clinicRatingCount: widget.clinic.clinicRatingCount,
                      ),
                    );
                    CustomScaffoldMessenger().showSuccess(
                      "Clinic was added to favorites!",
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
