Rails.application.config.after_initialize do
  if ENV["RUN_JOB"] == "true" then
    comments = Comment.all;
    p "show commets"
    p comments

    Thread.new do
      sleep 1 # ジョブ登録が完了するのを待つために少し待機
      Rails.logger.info "Job registration completed. Shutting down application."
      exit(0)
    end
  end
end
