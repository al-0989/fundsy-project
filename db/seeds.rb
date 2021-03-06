# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  arr = ["269 Commercial Dr, Jonquiere, QC, G7S 2S3",
  "8 Commercial Blvd #9, Hanover, ON, N4N 1Z7",
  "739 Stockton Ave, Gray Rapids, NB, E9B 1G6",
  "60 Sunrise Ave, North Bay, ON, P1B 2L4",
  "575 Washington St, Nanaimo, BC, V9R 6W5",
  "4634 Anania Dr, Vernon, BC, V1B 3Z4",
  "24 Sw Bridgeport Rd, Oakville, ON, L6J 7H9",
  "419 N Dixboro Rd #8, Gatineau, QC, J9J 0V4",
  "1 W Sierra Madre Blvd #9985, St Catharines, ON, L2M 1R4",
  "9 W Jackson Blvd, Surrey, BC, V3S 7P4",
  "4974 Rockburn Hill Rd #3, Surrey, BC, V4A 8M9",
  "8545 S Westshore Blvd, Cantley, QC, J8V 3K1",
  "258 S Ash Ave, Amherstburg, ON, N9V 1S8",
  "1 W Green Bay St, Saint John, NB, E2K 3R6",
  "8 Sylvan Ave, North York, ON, M3H 5X6",
  "9 Clove Rd, Pointe-aux-Trembles, QC, H1B 4R4",
  "10 Canal St, Pierrefonds, QC, H8Y 2A9",
  "62 N 3rd St, Calgary, AB, T2J 0S5",
  "2607 Market St, Chateauguay, QC, J6J 3J8",
  "62 15th Ave #63, Duncan, BC, V9L 2E9",
  "1 Clairemont Mesa Blvd, New Glasgow, NS, B2H 3Y5",
  "6 N Water St, Dauphin, MB, R7N 2C7",
  "1 S Kresson St, Alma, QC, G8E 1G2",
  "4 S 4th St, Calgary, AB, T2V 2M5",
  "326 Witherspoon St, Etobicoke, ON, M9R 2W5",
  "66 Hoffman St, St Thomas, ON, N5P 2E5",
  "185 Davis St, Saskatoon, SK, S7N 3M6",
  "20 Simpson Ferry Rd, Victoria, BC, V8Y 1H4",
  "7821 16th St Nw, Ajax, ON, L1S 1S7",
  "9 Pulaski Park Dr #7, North Bay, ON, P1B 2V6",
  "63 Baronne St, Port Moody, BC, V3H 1E8",
  "74 Chestnut St, Kitchener, ON, N2A 1S3",
  "4 Smith St #5, North York, ON, M3M 2A4",
  "4298 E Drinker St, York, ON, M6M 1V5",
  "80 S 33rd Pl, Greenfield Park, QC, J4V 3G8",
  "935 S Padre Island Dr, Halifax, NS, B3K 3E4",
  "3 B Main #117, Newmarket, ON, L3Y 3M4",
  "779 Moore St, Winnipeg, MB, R3R 2Z5",
  "14 Van Buren St, Peterborough, ON, K9H 4B6",
  "7 N Us Highway 67 #96, Ottawa, ON, K1S 2E4",
  "31 Mechanic St #9839, Stephenville, NL, A2N 2N4",
  "881 Route 38, North York, ON, M4A 2A6",
  "6 Monard Dr, Orleans, ON, K1C 2E5",
  "18 Cowesett Ave, Barrie, ON, L4N 5C5",
  "684 Albion Rd, Peterborough, ON, K9H 3K7",
  "8700 S Jefferson Rd #676, Lachine, QC, H8S 3A8",
  "4407 Chestnut Ridge Dr, Saint John, NB, E2K 5L7",
  "13 Midway Pl, Oakville, ON, L6H 5G1",
  "253 Hamilton Ave #1684, Pickering, ON, L1W 2P9",
  "8 W 41st Ave, Blainville, QC, J7C 2R9",
  "559 Bridge Plz, Etobicoke, ON, M8Y 1G5",
  "196 Touhy Ave, Scarborough, ON, M1E 3L6",
  "6 W Lincoln Ave, Saskatoon, SK, S7K 3K7",
  "7071 E 7th St #56, Verdun, QC, H4G 1X4",
  "784 Packerland Dr, Burlington, ON, L7L 5E8",
  "7823 N 36th Ave, North Vancouver, BC, V7H 2J2",
  "35 Milnor St, Valley, NS, B6L 3K5",
  "7 Saint Nicholas Ave, North Vancouver, BC, V7J 3P8"]
  Campaign.create(name: Faker::Company.name, description: Faker::Company.bs, goal: rand(10000000), user_id: [1, 2, 3, 4].sample(), address: arr.sample())

  100.times do
    c = FactoryGirl.create(:campaign)
    10.times { c.pledges.create(amount: rand(10000)) }
  end
end
