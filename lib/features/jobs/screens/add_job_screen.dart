import 'package:business_transactions/features/home/widgets/mesh_background.dart';
import 'package:business_transactions/features/jobs/controllers/add_job_controller.dart';
import 'package:business_transactions/features/jobs/widgets/add_job_header.dart';
import 'package:business_transactions/features/jobs/widgets/add_transaction_card.dart';
import 'package:business_transactions/features/jobs/widgets/create_job_button.dart';
import 'package:business_transactions/features/jobs/widgets/customer_details_card.dart';
import 'package:business_transactions/features/jobs/widgets/job_details_card.dart';
import 'package:business_transactions/features/jobs/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddJobScreen extends ConsumerStatefulWidget {
  const AddJobScreen({super.key});

  @override
  ConsumerState<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  // 1. Controller to manage scrolling
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2. LISTEN to state changes
    ref.listen(
      addJobControllerProvider.select((state) => state.isAdvancePayment),
      (previous, next) {
        // If toggled ON, scroll to bottom
        if (next == true) {
          // Small delay to let the Card expansion animation start first
          Future.delayed(const Duration(milliseconds: 300), () {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            }
          });
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const MeshBackground(),

          Column(
            children: [
              const AddJobHeader(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  // Ample padding at bottom so content isn't hidden by button
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SectionTitle(title: "CUSTOMER DETAILS"),
                      SizedBox(height: 8),
                      CustomerDetailsCard(),

                      SizedBox(height: 24),

                      SectionTitle(title: "JOB DETAILS"),
                      SizedBox(height: 8),
                      JobDetailsCard(),

                      SizedBox(height: 24),

                      AddTransactionCard(),

                      // Extra space at bottom to allow scrolling up above the keyboard
                      SizedBox(height: 124),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 0, 20, MediaQuery.of(context).padding.bottom + 20),
              child: const CreateJobButton(),
            ),
          ),
        ],
      ),
    );
  }
}
