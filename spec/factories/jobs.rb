FactoryBot.define do
  factory :job do

    url { 'bigcompany.com/job' }
    title { 'Head of ticketing' }
    location { 'London' }
    html_content { '<p>Job description</p>' }
    board { 'Jobs board' }

    employer { create(:employer) }
  end
end
