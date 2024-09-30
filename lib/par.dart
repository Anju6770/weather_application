// Widget customWidget() {
//   if (cs.isLoading) {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   } else if (cs.forecastData.isEmpty) {
//     return Center(
//       child: Text("No data found"),
//     );
//   } else {
//     return ListView.builder(
//       itemCount: cs.forecastData.length,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         final forecast = cs.forecastData[index];
//
//         // Calculate the time for the current index
//         DateTime forecastTime = DateTime.now().add(Duration(hours: index));
//
//         return Container(
//           color: index % 2 == 0 ? Colors.white : Colors.green,
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(
//                   "${iconStartPoint}${forecast.icon}${iconEndPoint}"),
//             ),
//             title: Text("Temperature: ${forecast.temperature}°C"),
//             subtitle: Text(Jiffy.parse("${forecast.dateTime}")
//                 .format(pattern: 'MMMM do yyyy')),
//             // Here we show the time incremented by 1 hour for each forecast item
//             trailing: Text(
//               DateFormat('h:mm a').format(forecastTime),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

