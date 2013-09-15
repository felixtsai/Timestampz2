module ReportsHelper

	def grade_complete_percentage(grade)
		students = Student.where(grade_level: grade)
		if !students.empty?
			totals = students.map { |student| student.complete_percentage }
			totals.reduce(:+) / students.count
		end
	end

	def grade_incomplete_percentage(grade)
		students = Student.where(grade_level: grade)
		if !students.empty?
			totals = students.map { |student| student.incomplete_percentage }
			totals.reduce(:+) / students.count
		end
	end

end