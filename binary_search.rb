# to benchmark and understand binary search mechanics

require 'benchmark'

def one(array)
	return array[0]
end

def n(array, value)
  array.each do |x|
  	return if x == value
  end
end

def n_squared(array1, array2, value)
	array1.each do |x|
		array2.each do |y|
			return if x == value
		end
	end
end

def o_log_n(arr, elem, low, high)
  mid = low+((high-low)/2).to_i
  if low > high 
    return nil
  end
  if elem < arr[mid]
    return o_log_n(arr, elem, low, mid-1)
  elsif elem > arr[mid]
    return o_log_n(arr, elem, mid+1, high)
  else
    return mid
  end
end

array = (1..1_000).to_a
million = (1..1_000_000).to_a
ten_mil = (1..10_000_000).to_a

Benchmark.bmbm do |x|
  x.report("1    :")	{ one( array ) }
  x.report("N    :")	{ n( array, array.length ) }
  x.report("N^2  :")	{ n_squared( array, array, array.length )}
  x.report("OlogN:")  { o_log_n( array, 500, 0, array.length )}
  x.report("OlogN:")	{ o_log_n( million, 500, 0, million.length )}
	x.report("OlogN:")	{ o_log_n( ten_mil, 500, 0, ten_mil.length )}
end

