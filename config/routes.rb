Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :institutions, :students

      resources :students do
        resources :enrollments, :bills
      end

    end
  end
end
