class Array
  def sum(start = 0)
    inject(start, &:+)
  end

  def fibonacci(n)
    n <= 1 ? n : fibonacci( n - 1 ) + fibonacci( n - 2 )
  end
end
