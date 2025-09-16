import 'package:flutter/material.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "New Ride Request",
      "body": "Someone requested a ride near you.",
      "time": "2m ago",
      "read": false
    },
    {
      "id": 2,
      "title": "Promo Offer 🎉",
      "body": "50% discount on your next ride! Limited time.",
      "time": "1h ago",
      "read": false
    },
    {
      "id": 3,
      "title": "Profile Updated",
      "body": "Your profile was updated successfully.",
      "time": "Yesterday",
      "read": true
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n["read"] = true;
      }
    });
  }

  void _clearAll() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notifications",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PopupMenuButton<String>(
                      color: Colors.white,
                      onSelected: (value) {
                        if (value == "mark_read") _markAllAsRead();
                        if (value == "clear_all") _clearAll();
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "mark_read",
                          child: Text("Mark all as read"),
                        ),
                        const PopupMenuItem(
                          value: "clear_all",
                          child: Text("Clear all"),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Text(
                      "No notifications",
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final n = notifications[index];
                      return Dismissible(
                        key: Key(n["id"].toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          setState(() {
                            notifications.removeAt(index);
                          });
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: n["read"]
                                ? Colors.white
                                : theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: n["read"]
                                    ? Colors.grey[300]
                                    : theme.colorScheme.primary,
                                child: Icon(
                                  n["read"]
                                      ? Icons.notifications_none
                                      : Icons.notifications_active,
                                  color: n["read"] ? Colors.grey[700] : Colors.white,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          n["title"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: n["read"]
                                                ? FontWeight.w500
                                                : FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          n["time"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      n["body"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (!n["read"])
                                IconButton(
                                  icon: const Icon(Icons.check_circle, color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      n["read"] = true;
                                    });
                                  },
                                ),
                            ],
                          ),
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
