import 'package:nuliga_app/model/match_result_detail.dart';
import 'package:nuliga_app/services/match-result/match_result_repository.dart';

class MatchResultService {
  final matchResultRepository = MatchResultRepository();

  Future<MatchResultDetail> getMatchResultDetails(
    String resultDetailUrl,
  ) async {
    return matchResultRepository.getMatchResult(resultDetailUrl);
  }
}
