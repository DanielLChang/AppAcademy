require_relative 'employee'

class Manager < Employee
  attr_accessor :employee_arr

  def initialize(name, title, salary, boss)
    @employee_arr = []
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    total_sal = 0
    employee_arr.each do |empl|
      total_sal += empl.salary
    end
    total_sal * multiplier
  end

  def add_employees(employee)
    @employee_arr.concat([employee])
  end
end

# ned = Manager.new("Ned", "Founder", 1_000_000, nil)
# darren = Manager.new("Darren", "TA Manager", 78_000, ned)
# shawna = Employee.new("Shawna", "TA", 12_000, darren)
# david = Employee.new("David", "TA", 10_000, darren)
