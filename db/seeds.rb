# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless AdminUser.find_by(email: "admin@cm.com")
  AdminUser.create!(email: "admin@cm.com", password: "Password123!", password_confirmation: "Password123!", first_name: "Admin", last_name: "User")
end

if State.count == 0
  [
    ['Alabama', 'AL'],
    ['Alaska', 'AK'],
    ['Arizona', 'AZ'],
    ['Arkansas', 'AR'],
    ['California', 'CA'],
    ['Colorado', 'CO'],
    ['Connecticut', 'CT'],
    ['Delaware', 'DE'],
    ['District of Columbia', 'DC'],
    ['Florida', 'FL'],
    ['Georgia', 'GA'],
    ['Hawaii', 'HI'],
    ['Idaho', 'ID'],
    ['Illinois', 'IL'],
    ['Indiana', 'IN'],
    ['Iowa', 'IA'],
    ['Kansas', 'KS'],
    ['Kentucky', 'KY'],
    ['Louisiana', 'LA'],
    ['Maine', 'ME'],
    ['Maryland', 'MD'],
    ['Massachusetts', 'MA'],
    ['Michigan', 'MI'],
    ['Minnesota', 'MN'],
    ['Mississippi', 'MS'],
    ['Missouri', 'MO'],
    ['Montana', 'MT'],
    ['Nebraska', 'NE'],
    ['Nevada', 'NV'],
    ['New Hampshire', 'NH'],
    ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'],
    ['New York', 'NY'],
    ['North Carolina', 'NC'],
    ['North Dakota', 'ND'],
    ['Ohio', 'OH'],
    ['Oklahoma', 'OK'],
    ['Oregon', 'OR'],
    ['Pennsylvania', 'PA'],
    ['Puerto Rico', 'PR'],
    ['Rhode Island', 'RI'],
    ['South Carolina', 'SC'],
    ['South Dakota', 'SD'],
    ['Tennessee', 'TN'],
    ['Texas', 'TX'],
    ['Utah', 'UT'],
    ['Vermont', 'VT'],
    ['Virginia', 'VA'],
    ['Washington', 'WA'],
    ['West Virginia', 'WV'],
    ['Wisconsin', 'WI'],
    ['Wyoming', 'WY']
  ].each do |state|
    State.create!(name: state[0], code: state[1])
  end
end

if LoanType.count == 0
  LoanType::LOAN_TYPES.each do |lt|
    LoanType.create(name: lt)
  end
end

unless Product.exists?(name: Product::ProductTypes::JUMBO_EXPRESS)
  Product.create!(name: Product::ProductTypes::JUMBO_EXPRESS, table_html: "<table></table>")
end

unless Product.exists?(name: Product::ProductTypes::JUMBO_PLUS)
  Product.create!(name: Product::ProductTypes::JUMBO_PLUS, table_html: "<table></table>")
end

if TurnTimeStat.count == 0
  TurnTimeStat.create!({
    drawing_docs: "1-2",
    underwriting: "2",
    conditions: "2",
    funding: "1-2"
  })
end