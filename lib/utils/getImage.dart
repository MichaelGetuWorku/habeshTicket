// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
// import 'package:file_picker/file_picker.dart';

// class GetImage extends StatefulWidget {
//   GetImage({Key? key}) : super(key: key);

//   @override
//   State<GetImage> createState() => _GetImageState();
// }

// class _GetImageState extends State<GetImage> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _image;
//   String? _uploadedFileURL;

//   // Future uploadFile() async {
//   //   final path = 'files/my-profile.jpg';
//   //   // final
//   // }
//   PlatformFile? pickedFile;
//   UploadTask? uploadTask;
//   Future uploadFile() async {
//     // FirebaseStorage storageReference = FirebaseStorage.instance;
//     // Reference ref =
//     //     storageReference.ref().child('files/${Path.basename(imageTemp.path)}}');
//     // UploadTask uploadTask = ref.putFile(imageTemp);
//     // uploadTask.then((res) {
//     //   res.ref.getDownloadURL().then((fileURL) {
//     //     setState(() {
//     //       _uploadedFileURL = fileURL;
//     //     });
//     //   });
//     // });
//     // uploadTask.then((res) {
//     //   res.ref.getDownloadURL().then((fileURL) {
//     //     setState(() {
//     //       _uploadedFileURL = fileURL;
//     //     });
//     //   });
//     // });
//     final path = 'files/${pickedFile!.name}';
//     final file = File(pickedFile!.path!);
//     final ref = FirebaseStorage.instance.ref().child(path);
//     uploadTask = ref.putFile(file);
//     final snapshot = await uploadTask!.whenComplete(() {});
//     _uploadedFileURL = await snapshot.ref.getDownloadURL();
//     print('Download URL:$_uploadedFileURL');
//   }

//   Future _takePicture() async {
//     final imageFile = await _picker.pickImage(
//       source: ImageSource.camera,
//       maxWidth: 500,
//     );
//     final imageTemp = File(imageFile!.path);
//     uploadFile();
//     Navigator.of(context).pop(imageTemp);
//   }

//   Future selectSingleImages() async {
//     final singleImage = await _picker.pickImage(source: ImageSource.gallery);
//     if (_image == null) return;
//     final imageTemp = File(singleImage!.path);
//     Navigator.of(context).pop(imageTemp);
//   }

//   Future selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result == null) return;
//     setState(() {
//       pickedFile = result.files.first;
//     });
//     uploadFile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0XFF757575),
//       height: 150,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 228, 236, 235),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               leading: const Icon(
//                 Icons.camera,
//                 color: Colors.white,
//               ),
//               title: Text('Take a Picture'),
//               onTap: _takePicture,
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.image,
//                 color: Colors.white,
//               ),
//               title: Text('Choose from Gallary'),
//               onTap: selectFile,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
