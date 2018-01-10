# require'bcrypt'
class AdminviewerController < ApplicationController
    before_action :authorize, :except => :show
    def adminview

    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params_post)

        @post.save


        ActiveRecord::Migration.create_table @post.title.to_sym do |t|
            if params[:stu] != nil
                params[:stu].values.each do |par|
                    t.string par
                end
            end
            if params[:additional] != nil
                params[:additional].values.each do |par|
                    t.string par
                end
            end
            t.timestamps
        end
        # create_arec(@post.title.to_sym)

        redirect_to "/adminviewer"
    end

    def show
        @post = Post.find(params[:id])
        table_name = @post.title
        @form = Class.new(ActiveRecord::Base){self.table_name = table_name}

        # sql = "select * from #{table_name}"
        # @form = ActiveRecord::Base.connection.execute(sql)
    end

    def destroy
        @post = Post.find(params[:id])
        tab_name = @post.title
        sql = "drop table #{tab_name}"
        @form = ActiveRecord::Base.connection.execute(sql)

        @post.destroy!

        redirect_to('/adminviewer')
    end

    def unstarted_list
        current_date = Time.current.to_date
        @all_posts = Post.where("start > current_date")
    end

    def ongoing_list
        current_date = Time.current.to_date
        @all_posts = Post.where("current_date BETWEEN start and end")
    end

    def closed_list
        current_date = Time.current.to_date
        @all_posts = Post.where("end <= current_date")
    end

    def pw_change
        @admin = Admin.find(session[:admin_id])
    end

    def pwc
        @admin = Admin.find(session[:admin_id]).try(:authenticate, params[:admin][:current_password])
        if (params[:admin][:new_password] == params[:admin][:new_password_confirmation])
            # @admin.password_cofirmation = params[:admin][:new_password]
            # @admin.password = @admin.password_cofirmation
            @admin.password_digest = BCrypt::Password.create(params[:admin][:new_password])
            @admin.save
            flash[:success] = "pw 변경 성공"
            redirect_to '/adminviewer'
        else
            flash[:warning] = "새 비밀번호를 다시 확인해 주십시오."
            redirect_to '/pw_change'
        # else
        #     flash[:warning] = "현재 비밀번호가 일치하지 않습니다."
        #     # kwlknfwekfnewkf
        #     redirect_to '/pw_change'
        end
    end

    def to_csv(tab)
        CSV.generate(options) do |csv|
           csv << column_names
           all.each do |product|
             csv << product.attributes.values_at(*column_names)
           end
         end
    end

    private
        def params_post
          params.require(:post).permit(:title, :start, :end, :content)
        end

end
