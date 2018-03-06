# require'bcrypt'
class AdminviewerController < ApplicationController
    before_action :authorize, :except => [:show, :create]
    def adminview

    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params_post)

        @post.save


        ActiveRecord::Migration.create_table (@post.id.to_s).to_sym do |t|
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

        flash[:success] = "새 접수항목 생성 완료"
        render 'adminviewer'
    end

    def show
        @post = Post.find(params[:id])
        table_name = @post.id.to_s
        @form = Class.new(ActiveRecord::Base){self.table_name = table_name}

        # sql = "select * from #{table_name}"
        # @form = ActiveRecord::Base.connection.execute(sql)
    end

    def destroy
        @post = Post.find(params[:id])
        tab_name = @post.id.to_s
        sql = "drop table #{tab_name}"
        @form = ActiveRecord::Base.connection.execute(sql)

        @post.destroy!

        flash[:success] = "삭제 완료"
        redirect_to('/apply/adminviewer')
    end

    def unstarted_list
        current_date = Time.current.to_date
        posts = Post.where("start > current_date").reverse_order
        @all_posts = posts.paginate(:page => params[:page])
        if params[:page] == "1" || params[:page] == nil
            @idx = posts.count
        else
            @idx = posts.count - (30*(params[:page].to_i-1))
        end
    end

    def ongoing_list
        current_date = Time.current.to_date
        posts = Post.where("current_date BETWEEN start and end").reverse_order
        @all_posts = posts.paginate(:page => params[:page])
        if params[:page] == "1" || params[:page] == nil
            @idx = posts.count
        else
            @idx = posts.count - (30*(params[:page].to_i-1))
        end
    end

    def closed_list
        current_date = Time.current.to_date
        posts = Post.where("end <= current_date").reverse_order
        @all_posts = posts.paginate(:page => params[:page])
        if params[:page] == "1" || params[:page] == nil
            @idx = posts.count
        else
            @idx = posts.count - (30*(params[:page].to_i-1))
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        @post.update(params_post_edit)
        redirect_to post_path(@post)
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
            redirect_to '/apply/adminviewer'
        else
            flash[:warning] = "새 비밀번호를 다시 확인해 주십시오."
            redirect_to '/apply/pw_change'
        # else
        #     flash[:warning] = "현재 비밀번호가 일치하지 않습니다."
        #     # kwlknfwekfnewkf
        #     redirect_to '/pw_change'
        end
    end

    def export_csv
        @post = Post.find(params[:post_id])
        table_name = @post.id.to_s
        @form = Class.new(ActiveRecord::Base){self.table_name = table_name}
        package = Axlsx::Package.new
        workbook = package.workbook
        @appliers = @form.all
        workbook.add_worksheet(name: table_name) do |sheet|
          sheet.add_row @form.column_names
          @appliers.each do |ap|
            tmp = ap.attributes.values
            sheet.add_row tmp
          end
        end

        outstrio = StringIO.new
        package.use_shared_strings = true # Otherwise strings don't display in iWork Numbers
        outstrio.write(package.to_stream.read)
        # outstrio.string
        send_data outstrio.string, :filename=>"#{table_name + '_' + Time.current.to_date.to_s}.xlsx"

        package.serialize("basic.xlsx")
        # send_file("#{Rails.root}/tmp/basic.xlsx", filename: "#{table_name + '_' + Time.current.to_date.to_s}.xlsx", type: "application/xlsx")
        # send_file(package.to_stream.read, type: "application/xlsx", filename: "#{table_name + '_' + Time.current.to_date.to_s}.xlsx")
    end

    private
        def params_post
          params.require(:post).permit(:title, :start, :end, :content)
        end
    private
        def params_post_edit
          params.require(:post).permit(:start, :end)
        end

end
