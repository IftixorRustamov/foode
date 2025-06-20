import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = sl<AppTextStyles>();
    final List<Map> chats = [
      {
        'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
        'name': 'Guy Hawkins',
        'message': "I'll be there in 2 mins",
        'time': '20.00',
        'unread': 3,
      },
      {
        'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
        'name': 'Dianne Russell',
        'message': 'woohoooo',
        'time': '16.40',
        'unread': 0,
      },
      {
        'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
        'name': 'Theresa Webb',
        'message': 'The Good Work',
        'time': '13.10',
        'unread': 0,
      },
      {
        'avatar': 'https://randomuser.me/api/portraits/women/4.jpg',
        'name': 'Jenny Wilson',
        'message': "I'll be there in 2 mins",
        'time': '09.20',
        'unread': 0,
      },
      {
        'avatar': 'https://randomuser.me/api/portraits/men/5.jpg',
        'name': 'Courtney Henry',
        'message': 'aww',
        'time': '08.00',
        'unread': 0,
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: appW(12)),
          child: CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Icon(Icons.menu, color: AppColors.primary),
          ),
        ),
        title: Text('Chat', style: textStyles.bold(fontSize: 24, color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(appW(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: appW(16)),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.filter_list, color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: appH(24)),
            Expanded(
              child: ListView.separated(
                itemCount: chats.length,
                separatorBuilder: (_, __) => SizedBox(height: appH(18)),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.04),
                          blurRadius: 12,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(chat['avatar']!),
                          radius: appW(28),
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                        ),
                        SizedBox(width: appW(16)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(chat['name']!, style: textStyles.semiBold(fontSize: 18, color: Colors.black)),
                              SizedBox(height: 4),
                              Text(chat['message']!, style: textStyles.regular(fontSize: 14, color: AppColors.neutral4)),
                            ],
                          ),
                        ),
                        if (chat['unread'] != null && chat['unread'] > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text('${chat['unread']}', style: textStyles.semiBold(color: Colors.white, fontSize: 14)),
                          ),
                        SizedBox(width: appW(12)),
                        Text(chat['time']!, style: textStyles.regular(fontSize: 15, color: AppColors.neutral4)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 