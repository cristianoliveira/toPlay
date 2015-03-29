task cron: :environment do
  Merit::RankRules.new.check_rank_rules
end
