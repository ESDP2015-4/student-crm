json.array!(@periods) do |period|
  json.extract! period, :id, :title, :course_element_id,:course_id
  json.extract! Group.find(period.group_id), :name
  json.extract! CourseElement.find(period.course_element_id), :theme, :element_type
  json.start period.commence_datetime
end