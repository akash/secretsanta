module ApplicationHelper
	def javascript(*files)
		content_for(:javascripts) { javascript_include_tag(*files) }
	end
end
