module ApplicationHelper

	def options_for_story_select
	[
	    ["1 Story", QuickPricer::Story::OneStory],
	    ["2 Stories", QuickPricer::Story::TwoStory],
	    ["3 Stories", QuickPricer::Story::ThreeStory],
	    ["4 Stories", QuickPricer::Story::FourStory]
	]
	end
end
