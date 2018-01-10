class UviewerController < ApplicationController
    skip_before_action :verify_authenticity_token
  def index
      current_date = Time.current.to_date
      @all_posts = Post.where("current_date BETWEEN start and end")
  end

  def show
      @post = Post.find(params[:id])
      table_name = @post.title
      @form = Class.new(ActiveRecord::Base){self.table_name = table_name}

      # sql = "select * from #{table_name}"
      # @form = ActiveRecord::Base.connection.execute(sql)
  end

  def apply_form
      @post = Post.find(params[:post_id])
      tab_name = @post.title
      @form = Class.new(ActiveRecord::Base){self.table_name = tab_name}
  end

  def apply
      @post = Post.find(params[:post_id])
      tab_name = @post.title
      @form = Class.new(ActiveRecord::Base){self.table_name = tab_name}

      if @form.all.find_by(학번: params[:stid]) != nil
          flash[:primary] = ('이미 신청하셨습니다. 수정할 정보를 입력하세요.')
          redirect_to :action => :edit_form, :params => {:stid => params[:stid], :post_id => params[:post_id]}and return
      else
          temp = @form.new
          temp.이름 = params[:name] # stid email pno grade
          temp.학번 = params[:stid]
          if params[:email] != nil
              temp.이메일 = params[:email]
          end

          if params[:pno] != nil
              temp.전화번호 = params[:pno]
          end
          if params[:grade] != nil
              temp.학년 = params[:grade]
          end

          parexc = params.select{|n| n != "name" && n != "stid" && n != "email" && n != "pno" && n != "grade" && n != "post_id"}


          temp.attribute_names.select{|n| n != "이름" && n != "학번" && n != "학년" && n != "이메일" && n != "전화번호" && n != "id" && n != "created_at" && n != "updated_at"}.zip(parexc).each do |att, val|
               temp[att] = val
           end

           if temp.save
               flash[:success] = ('신청 완료.')
               redirect_to '/'
           end
       end
  end

  def edit_form
      @post = Post.find(params[:post_id])
      tab_name = @post.title
      @form = Class.new(ActiveRecord::Base){self.table_name = tab_name}

      @student = @form.all.find_by(학번: params[:stid])
  end

  def edit
      @post = Post.find(params[:post_id])
      tab_name = @post.title
      @form = Class.new(ActiveRecord::Base){self.table_name = tab_name}


      temp = @form.find(params[:st_id])
      temp.이름 = params[:name] # stid email pno grade
      temp.학번 = params[:stid]
      if params[:email] != nil
          temp.이메일 = params[:email]
      end

      if params[:pno] != nil
          temp.전화번호 = params[:pno]
      end

      if params[:grade] != nil
          temp.학년 = params[:grade]
      end

      parexc = params.select{|n| n != "name" && n != "stid" && n != "email" && n != "pno" && n != "grade" && n != "post_id"}


      temp.attribute_names.select{|n| n != "이름" && n != "학번" && n != "학년" && n != "이메일" && n != "전화번호" && n != "id" && n != "created_at" && n != "updated_at"}.zip(parexc).each do |att, val|
           temp[att] = val
       end

       if temp.save
           flash[:success] = ('수정 완료.')
           redirect_to '/'
       end
  end
end
