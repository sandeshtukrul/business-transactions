import 'package:business_transactions/data/local/job_local_data_source.dart';
import 'package:business_transactions/models/job.dart';
import 'package:business_transactions/models/transaction.dart';

class JobRepository {
  final JobLocalDataSource localDataSource;

  JobRepository(this.localDataSource);

  // --- READS ---
  Future<List<Job>> getActiveJobs() async {
    final allJobs = await localDataSource.getAllJobs();
    // Filter active/open
    final activeJobs = allJobs.where((job) => job.status == JobStatus.open).toList();
    // Sort Newest First
    activeJobs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return activeJobs;
  }

  // --- WRITES ---
  
  /// Direct Save (Create or Update)
  Future<void> saveJob(Job job) {
    return localDataSource.saveJob(job);
  }

  Future<void> addTransaction(String jobId, Transaction transaction) {
    return localDataSource.addTransactionToJob(jobId, transaction);
  }
}