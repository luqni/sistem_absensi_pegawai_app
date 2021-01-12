import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:spo_balaesang/screen/image_detail_screen.dart';
import 'package:spo_balaesang/utils/view_util.dart';
import 'package:spo_balaesang/widgets/image_placeholder_widget.dart';

class EmployeePresenceCardWidget extends StatelessWidget {
  const EmployeePresenceCardWidget(
      {this.presenceType,
      this.attendTime,
      this.status,
      this.address,
      this.photo,
      this.heroTag,
      this.isApprovalCard = false,
      this.buttonWidget,
      this.point,
      this.color});

  final String presenceType;
  final String point;
  final String attendTime;
  final String status;
  final String address;
  final String photo;
  final String heroTag;
  final bool isApprovalCard;
  final Widget buttonWidget;
  final Color color;

  Widget _buildCancelButton(String status) {
    if ((status != 'Tepat Waktu' && !status.contains('Terlambat')) ||
        !isApprovalCard) {
      return SizedBox();
    }
    return Column(
      children: <Widget>[Divider(), buttonWidget],
    );
  }

  Widget _showImage(String photo) {
    if (photo.isEmpty) {
      return ImagePlaceholderWidget(
        label: 'Tidak ada foto!',
        child: Icon(
          Icons.image_not_supported_rounded,
          color: Colors.grey,
        ),
      );
    }

    return InkWell(
      onTap: () {
        Get.to(ImageDetailScreen(
          tag: heroTag,
          imageUrl: photo,
        ));
      },
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            placeholder: (_, __) => ImagePlaceholderWidget(
              label: 'Memuat Foto',
              child: SpinKitFadingCircle(
                size: 25.0,
                color: Colors.blueAccent,
              ),
            ),
            imageUrl: photo,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => ImagePlaceholderWidget(
              label: 'Gagal memuat foto',
              child: Icon(
                Icons.image_not_supported_rounded,
                color: Colors.grey,
              ),
            ),
            width: Get.width,
            height: 250.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: Get.width,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                presenceType,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Divider(thickness: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Jam Absen',
                    style: labelTextStyle,
                  ),
                  Text(
                    attendTime.isEmpty ? '-' : attendTime,
                  )
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Poin Kehadiran',
                    style: labelTextStyle,
                  ),
                  Text(
                    '$point',
                    style: TextStyle(
                      color: color,
                    ),
                  )
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Status Kehadiran',
                    style: labelTextStyle,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: color,
                    ),
                  )
                ],
              ),
              SizedBox(height: 4.0),
              Divider(thickness: 1),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.grey[600],
                    size: 20.0,
                  ),
                  SizedBox(width: 4.0),
                  Text('Lokasi', style: labelTextStyle)
                ],
              ),
              SizedBox(height: 4.0),
              AutoSizeText(
                address.isEmpty ? '-' : address,
                maxLines: 3,
                minFontSize: 10.0,
                maxFontSize: 12.0,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              ),
              Divider(thickness: 1),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.photo,
                    color: Colors.grey[600],
                    size: 20.0,
                  ),
                  SizedBox(width: 4.0),
                  Text('Foto Wajah', style: labelTextStyle)
                ],
              ),
              SizedBox(height: 4.0),
              _showImage(photo),
              SizedBox(height: 8.0),
              _buildCancelButton(status)
            ],
          ),
        ),
      ),
    );
  }
}
