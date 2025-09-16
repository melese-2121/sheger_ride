import 'package:flutter/material.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final notifications = [
      {
        "title": "Ride Completed",
        "message": "Your ride from Bole to Piassa has been completed successfully.",
        "time": "2h ago",
        "icon": Icons.check_circle,
        "color": Colors.green
      },
      {
        "title": "Payment Received",
        "message": "150 ETB has been charged to your wallet.",
        "time": "Yesterday",
        "icon": Icons.account_balance_wallet,
        "color": Colors.blue
      },
      {
        "title": "Promo Alert",
        "message": "Get 20% off on your next ride. Valid until Sep 30!",
        "time": "2 days ago",
        "icon": Icons.local_offer,
        "color": Colors.orange
      },
      {
        "title": "Driver Assigned",
        "message": "Your driver Abebe is on the way to pick you up.",
        "time": "Sep 10",
        "icon": Icons.directions_car,
        "color": Colors.purple
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Text(
                "Notifications",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Notification List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor:
                          (n["color"] as Color).withOpacity(0.15),
                      child: Icon(
                        n["icon"] as IconData,
                        size: 28,
                        color: n["color"] as Color,
                      ),
                    ),
                    title: Text(
                      n["title"].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          n["message"].toString(),
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          n["time"].toString(),
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
