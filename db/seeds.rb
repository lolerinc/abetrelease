# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User_list = [
	[ "jkirk", "James", "Kirk", "jtkirk@starfleet.edu", "aaaaaaaa", "A" ],
	[ "spock", "Spock", "Sp0ck", "spock@starfleet.edu", "dddddddd", "C"],
	[ "mccoy", "Leonard", "McCoy", "bones@starfleet.edu", "bbbbbbbb", "I" ],
	[ "pchekov", "Pavel", "Chekov", "pavel.chekov@starfleet.edu", "cccccccc", "I" ]
]

User_list.each do |name, fname, lname, email, pass, perm|
	User.create( name: name, fname: fname, lname: lname, email: email, 
		password: pass, password_confirmation: pass, permission: perm) 
end


Degree_List = [
	"ENGR",
	"COSC",
	"GISC"
]

Degree_List.each do |name|
	Degree.create(name: name)
end


Track_List = [
	[ "COSC", "Systems Programming" ],
	[ "ENGR", "Mechanical Engineering" ],
	[ "ENGR", "Electrical Engineering" ],
	[ "ENGR", "Engineering Technology" ],
	[ "GISC", "Geographic Information Science" ]
]

Track_List.each do |degree, name|
	Track.create(degree: Degree.find_by(name: degree), name: name)
end


Approver_List = [
	[ "pchekov", "Systems Programming" ]
]

Approver_List.each do |user, track|
	Approver.create(user: User.find_by(name: user), track: Track.find_by(name: track))
end


Course_List = [
	[ "COSC", "1435", "Introduction to Problem Solving with Computers I" ],
	[ "COSC", "1436", "Introduction to Problem Solving with Computers II" ],
	[ "COSC", "2334", "Computer Architecture" ],
	[ "MATH", "2413", "Calculus I" ],
	[ "PHYS", "2425", "University Physics I" ],
	[ "PHYS", "2426", "University Physics II" ],
	[ "ENGR", "1211", "Foundations of Engineering I" ],
	[ "ENGR", "1212", "Foundations of Engineering II" ],
	[ "MEEN", "3330", "Solid Mechanics for Mechanical Engineering"]
]

Course_List.each do |code_prefix, code_suffix, name|
	Course.create(code_prefix: code_prefix, code_suffix: code_suffix, name: name)
end


Offering_List = [
	[ "34563", "001", 2016, "9", "Eval stuff", "COSC", "1435" ],
	[ "45687", "002", 2016, "9", "Eval stuff", "COSC", "1435" ],
	[ "12347", "003", 2016, "9", "Eval stuff", "COSC", "1436" ],
	[ "13235", "001", 2016, "9", "Eval stuff", "MEEN", "3330" ],
	[ "12334", "004", 2016, "9", "Eval stuff", "MATH", "2413" ]
]

Offering_List.each do |crn, section, year, term, evaluation, code_prefix, code_suffix|
	Offering.create(CRN: crn, section: section, year: year, term: term, evaluation: evaluation, course: Course.find_by(code_prefix: code_prefix, code_suffix: code_suffix))
end


CourseTrackList_List = [
	[ "Systems Programming", "COSC", "1435" ],
	[ "Systems Programming", "COSC", "1436" ],
	[ "Systems Programming", "MATH", "2413" ],
	[ "Mechanical Engineering", "MEEN", "3330" ],
	[ "Mechanical Engineering", "MATH", "2415" ]
]

CourseTrackList_List.each do |track, code_prefix, code_suffix|
	CourseTrackList.create(track: Track.find_by(name: track), 
		course: Course.find_by(code_prefix: code_prefix, code_suffix: code_suffix))
end


Teaching_List = [
	[ "mccoy", "34563" ],
	[ "mccoy", "45687" ],
	[ "pchekov", "12347" ],
	[ "pchekov", "13235" ],
	[ "pchekov", "12334" ]
]

Teaching_List.each do |user, crn|
	Teaching.create(user: User.find_by(name: user), offering: Offering.find_by(CRN: crn))
end


AbetOutcome_List = [
	["Systems Programming", "A", "An ability to apply knowledge of computing and mathematics..."],
	["Systems Programming", "B", "An ability to analyze a problem, and identify and define..."],
	["Systems Programming", "C", "An ability to design, implement, and evaluate..."],
	["Mechanical Engineering", "A", "Ability to apply mathematics, science and engineering principles"],
	["Mechanical Engineering", "B", "Ability to design and conduct experiments, analyze and interpret data"],
	["Mechanical Engineering", "C", "Ability to design a system, component, or process to meet desired needs"]
]

AbetOutcome_List.each do |track, code, desc|
	AbetOutcome.create(track: Track.find_by(name: track), code: code, desc: desc)
end


MasterMatrix_List = [
	["Systems Programming", "COSC", "1435", "A"],
	["Systems Programming", "COSC", "1435", "C"],
	["Systems Programming", "MATH", "2413", "B"],
	["Mechanical Engineering", "MATH", "2413", "A"],
	["Mechanical Engineering", "MEEN", "3330", "C"]
]

MasterMatrix_List.each do |track, code_prefix, code_suffix, outcome_code|
	MasterMatrix.create(track: Track.find_by(name: track),
		course: Course.find_by(code_prefix: code_prefix, code_suffix: code_suffix),
		abet_outcome: AbetOutcome.find_by(track: Track.find_by(name: track),
			code: outcome_code))
end


Document_List = [
  ["EOCM1", "EOCM", "Approved - Complete", 2016, 03, 13, 2016, 05, 11],
	["EOCM2", "EOCM", "Not Submitted", 2016, 10, 12, 2017, 2, 02],
	["PIE1", "PIE", "Not Submitted", 2016, 10, 07, 2016, 10, 12],
	["AIR1", "AIR", "Not Reviewed", 2016, 03, 10, 2016, 05, 01],
	["AIR2", "AIR", "Revisions Required", 2016, 03, 10, 2016, 10, 10],
	["EOCM3", "EOCM", "Approved - Complete", 2016, 10, 10, 2015, 12, 12]
]

Document_List.each do |name, formType, status, a_y, a_m, a_d, d_y, d_m, d_d|
	Document.create(name: name, formType: formType, status: status, 
		assigned: DateTime.new(a_y, a_m, a_d), due: DateTime.new(d_y, d_m, d_d))
end

Library_List = [
	["EOCM1", "34563"],
	["EOCM2", "45687"],
	["PIE1", "12347"],
	["AIR1", "13235"],
	["AIR2", "12334"],
	["EOCM3", "34563"]
]

Library_List.each do |document, offering|
	Library.create(document: Document.find_by(name: document), 
		offering: Offering.find_by(CRN: offering))
end


Course_Outcome_List = [
	["Hard Work", "34563", "Excellent"],
	["Tricky Problems", "34563", "Good"],
	["Jive Talk", "34563", "Needs Major Improvement"],
	["Semi-hard Work", "45687", "Satisfactory"],
	["For Loops", "45687", "Good"],
	["string compares", "45687", "Needs Major Improvement"],
	["Machines", "12347", "Good"],
	["Ethical Use of Machines", "12347", "Needs Major Improvement"],
	["Cool Tapes", "12347", "Good"],
	["Copy-Paste from Stack Overflow", "13235", "Excellent"],
	["Think Original Thoughts", "13235", "Needs Improvement"],
	["Version Control", "13235", "Satisfactory"],
	["Look Ma, No Hands!", "12334", "Good"],
	["Disaster Recovery", "12334", "Needs Major Improvement"],
	["Error Checking", "12334", "Satisfactory"]
]

Course_Outcome_List.each do |outcome, offering, rating|
	CourseOutcome.create(outcome: outcome, rating: rating,
		offering: Offering.find_by(CRN: offering))
end

ABET_Metrics_List = [
	["34563", "A", "pass"],
	["34563", "B", "pass"],
	["45687", "A", "fail"],
	["45687", "B", "pass"],
	["12347", "B", "pass"],
	["12347", "C", "pass"],
	["13235", "A", "fail"],
	["13235", "B", "fail"],
	["12334", "A", "fail"],
	["12334", "B", "pass"]
]

ABET_Metrics_List.each do |crn, abet, rating|
	AbetMetric.create(offering: Offering.find_by(CRN: crn), abet: abet, rating: rating)
end

AIR_List = [
	[ "AIR1", "Limited Ability", "Some ABET Outcome", "Pavel Chekov", "", "", "", "Student Ability Review", 2016, 10, 10, "The student have limited abilities", "Work harder", "The students improved" ],
	[ "AIR2", "Applied Math", "Other ABET Outcome", "Pavel Chekov", "", "", "", "Applied Math Review", 2016, 11, 12, "The student can't apply math", "Learn harder", "The students improved" ]
]

AIR_List.each do |document, name, abetOutcome, assignee1, assignee2, assignee3, assignee4, meetingName, a_y, a_m, a_d, analysis, taken, conclusion|
	AIR.create(document: Document.find_by(name: document), name: name, abetOutcome: abetOutcome, assignee1: assignee1, assignee2: assignee2, assignee3: assignee3, assignee4: assignee4, meetingName: meetingName, meetingDate: DateTime.new(a_y, a_m, a_d), analysis: analysis, taken: taken, conclusion: conclusion)
end

EOCM_List = [
	[ "EOCM1", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
				"Etiam semper ullamcorper malesuada.", 
				"iProin tempus, ex id blandit ullamcorper, risus nisl hendrerit urna", 
				"Suspendisse pretium tellus id pretium elementum. Nam pretium odio nec auctor ultricies. Etiam nisl sem, malesuada et finibus sit amet, vulputate eu libero. ", 
				"Aliquam ultricies, est vitae condimentum sollicitudin, dolor nulla suscipit nisi, sed hendrerit nulla dui eget mauris. Nunc porttitor, quam ut tristique congue, quam velit semper libero, in consectetur nulla dui eu ante. ", 
				"Cras imperdiet orci quis mauris aliquet, nec porta nunc gravida. ", 
				"Nunc consectetur ante id convallis dignissim. Quisque egestas dignissim elit, in pharetra quam tincidunt in. Praesent a neque ut orci dignissim egestas. ", 
				"In at dolor quis urna laoreet porttitor.", 
				"Aenean tincidunt non dolor quis bibendum. Suspendisse pretium tellus id pretium elementum. Nam pretium odio nec auctor ultricies. Etiam nisl sem, malesuada et finibus sit amet, vulputate eu libero. Vestibulum nisi ligula, egestas in sapien ac, gravida sollicitudin orci." ],
	[ "EOCM2", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
	        "Etiam semper ullamcorper malesuada.", 
					        "iProin tempus, ex id blandit ullamcorper, risus nisl hendrerit urna", 
									        "Suspendisse pretium tellus id pretium elementum. Nam pretium odio nec auctor ultricies. Etiam nisl sem, malesuada et finibus sit amet, vulputate eu libero. ",
													        "Aliquam ultricies, est vitae condimentum sollicitudin, dolor nulla suscipit nisi, sed hendrerit nulla dui eget mauris. Nunc porttitor, quam ut tristique congue, quam velit semper libero, in consectetur nulla dui eu ante. ",
																	        "Cras imperdiet orci quis mauris aliquet, nec porta nunc gravida. ",
																					        "Nunc consectetur ante id convallis dignissim. Quisque egestas dignissim elit, in pharetra quam tincidunt in. Praesent a neque ut orci dignissim egestas. ",
																									        "In at dolor quis urna laoreet porttitor.",
																													        "Aenean tincidunt non dolor quis bibendum. Suspendisse pretium tellus id pretium elementum. Nam pretium odio nec auctor ultricies. Etiam nisl sem, malesuada et finibus sit amet, vulputate eu libero. Vestibulum nisi ligula, egestas in sapien ac, gravida sollicitudin orci."],
	[ "EOCM3", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
	        "Etiam semper ullamcorper malesuada.", 
					        "iProin tempus, ex id blandit ullamcorper, risus nisl hendrerit urna", 
									        "Suspendisse pretium tellus id pretium elementum. Nam pretium odio nec auctor ultricies. Etiam nisl sem, malesuada et finibus sit amet, vulputate eu libero. ",
													        "Aliquam ultricies, est vitae condimentum sollicitudin, dolor nulla suscipit nisi, sed hendrerit nulla dui eget mauris. Nunc porttitor, quam ut tristique congue, quam velit semper libero, in consectetur nulla dui eu ante. ",
																	        "Cras imperdiet orci quis mauris aliquet, nec porta nunc gravida. ",
																					        "Nunc consectetur ante id convallis dignissim. Quisque egestas dignissim elit, in pharetra quam tincidunt in. Praesent a neque ut orci dignissim egestas. ",
																									        "In at dolor quis urna laoreet porttitor.",
																													        "Aenean tincidunt non dolor quis bibendum. Suspendisse pretium tellus id pretium elementum. Nam pretium odio nec auctor ultricies. Etiam nisl sem, malesuada et finibus sit amet, vulputate eu libero. Vestibulum nisi ligula, egestas in sapien ac, gravida sollicitudin orci."]
]

EOCM_List.each do |document, evaluation, comment_outcomes, comment_worked, comment_changes, comment_rec, comment_implemented, comment_results, comment_additional, comment_failed|
	EOCM.create(document: Document.find_by(name: document), evaluation: evaluation, comment_outcomes: comment_outcomes, comment_worked: comment_worked, comment_changes: comment_changes, comment_rec: comment_rec, comment_implemented: comment_implemented, comment_results: comment_results, comment_additional: comment_additional, comment_failed: comment_failed)
end

PIE_List = [
	[ "PIE1", "Praesent a neque ut orci dignissim egestas. Integer pharetra eleifend lorem",
		"Aenean a faucibus dolor, in convallis ligula. Pellentesque lobortis congue neque id imperdiet.", 
		"Sed sodales turpis velit, nec laoreet sem porttitor quis. Vivamus eu sapien dolor.", 2.2, "3", 1.0, "1", "0 + 0 - 0 SQRT(0) = BAD" ]
]

PIE_List.each do |document, name, abet_outcome, description, tpercent, tscore, rpercent, rscore, calculation|
	PIE.create(document: Document.find_by(name: document), name: name, abet_outcome: abet_outcome, description: description, tpercent: tpercent, tscore: tscore, rpercent: rpercent, rscore: rscore, calculation: calculation)
end



