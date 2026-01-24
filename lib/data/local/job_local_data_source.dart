import 'package:business_transactions/models/job.dart';
import 'package:business_transactions/models/transaction.dart';
import 'package:hive_ce/hive_ce.dart';

class JobLocalDataSource {
  final Box<Job> _jobsBox;

  JobLocalDataSource(this._jobsBox);

  /// Get ALL jobs
  Future<List<Job>> getAllJobs() async {
    return _jobsBox.values.toList();
  }

  /// Add or Update a Job
  /// This handles both Create (new ID) and Update (existing ID)
  Future<void> saveJob(Job job) async {
    // If your Job model extends HiveObject, you can use job.save() 
    // But putting explicitly by ID is safer for strict control.
    await _jobsBox.put(job.id, job);
  }

  /// Get a specific job by ID
  Future<Job?> getJobById(String jobId) async {
    try {
      // Direct lookup is faster than filtering list if using ID as key
      return _jobsBox.get(jobId) ?? _jobsBox.values.firstWhere((j) => j.id == jobId);
    } catch (e) {
      return null;
    }
  }

  /// Add a transaction to a specific job
  Future<void> addTransactionToJob(String jobId, Transaction transaction) async {
    final job = await getJobById(jobId);
    if (job != null) {
      job.transactions.add(transaction);
      await saveJob(job); // Re-save to persist list change
    }
  }
}