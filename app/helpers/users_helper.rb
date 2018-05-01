module UsersHelper
  @visitor_visits = {}

  def find_user_visits(user_email)
    @visitor_visits = {}

    visitors = Visitor.all
    visitors.each do |visitor|
      @visitor_visits[visitor.id]
      if visitor.email == user_email
        @visitor_visits[visitor.id] = visitor
      end
    end
    @visitor_visits
  end
end
