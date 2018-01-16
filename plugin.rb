# name: civically-solved-extension
# about: Extends the solved plugin
# version: 0.1
# authors: Angus McLeod
# url: https://github.com/civicallyhq/x-civically-solved

after_initialize do
  Guardian.class_eval do
    def can_accept_answer?(topic)
      (allow_accepted_answers_on_category?(topic.category_id) ||
       topic.subtype == 'question'
      ) && (
        is_staff? || (
          authenticated? && ((!topic.closed? && topic.user_id == current_user.id) ||
                            (current_user.trust_level >= SiteSetting.accept_all_solutions_trust_level))
        )
      )
    end
  end
end
