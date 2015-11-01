class WelcomeController < ApplicationController
  def index
    @page_name = 'home'

    @carousel_sections = [
      {
        image: "banner/0.jpg",
        header: "Help make every loan a success story",
        text: "We offer the highest-caliber products, set at the right rates, delivered by the most qualified people. We take your loans personally. It’s our job to make every loan a success story.",
        button_text: "OUR MISSION STATEMENT"
      },
      {
        image: "banner/2.jpg",
        header: "Seven Days Pays",
        text: "One of Commerce Mortgage Wholesale’s core beliefs is the importance of taking care of our employees. If you can submit all documents within seven days, you’ll receive an appraisal credit. With Commerce Mortgage Wholesale, seven days pays.",
        button_text: "OUR SERVICE TRADEMARK"
      },
      {
        image: "top.jpg",
        header: "Jumbo Love",
        text: "We offer 10% down on select programs up to $1.5 million with no PMI required, fixed rate or ARM. Unlimited cash out options up to max LTV. FICO scores as low as 680. That's just the begining.",
        button_text: "JUMBO LOAN LEADER"
      },
      {
        image: "banner/3.jpg",
        header: "Black Card Service",
        text: "Get direct access to senior management, guaranteed 24-hour underwriting, and additional perks like milestone rewards.<br>No one likes to wait in line.<br>With us, you go to the front of the line, every time.",
        button_text: "BLACK CARD SERVICE"
      }
    ]

    @product_links = [
      {
        text: "JUMBO",
        link: loan_programs_path(anchor: "jumbo")
      },
      {
        text: "CONVENTIONAL",
        link: loan_programs_path(anchor: "conventional")
      },
      {
        text: "CONVENTIONAL ARM",
        link: loan_programs_path(anchor: "conventional_arm")
      },
      {
        text: "GOVERNMENT",
        link: loan_programs_path(anchor: "government")
      },
      {
        text: "SEE ALL OUR PRODUCTS",
        link: loan_programs_path
      }
    ]
  end
end