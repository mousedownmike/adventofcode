def read_row(stack_line)
  crate_cols = 9
  crate_space = 3
  crates = Array.new(crate_cols)
  crates_index = 0
  while crates_index < crate_cols
    crate_id = stack_line[crates_index * (crate_space + 1) + 1]
    if crate_id != " "
      crates[crates_index] = crate_id
    end
    crates_index = crates_index + 1
  end
  crates
end

def test_read_row
  test_row_strings = ['            [C]         [N] [R]    ',
                      '[W] [P] [P] [D] [G] [P] [B] [P] [V]']
  test_rows = [[nil, nil, nil, 'C', nil, nil, 'N', 'R', nil],
               %w[W P P D G P B P V]]

  test_row_strings.each_with_index do |row, i|
    raise "FAILED read_row #{row} == #{test_rows[i].join(',')}" unless read_row(row) == test_rows[i]
  end
end

test_read_row

def load_stacks(data_file)
  stacks = Array.new(9) { Array.new(0) }
  IO.foreach(data_file) do |line|
    if line.index('[')
      read_row(line).each_with_index do |id, i|
        if id != nil
          stacks[i].prepend(id)
        end
      end
    end
  end
  stacks
end

def test_load_stacks
  stacks = load_stacks("day5.txt")
  raise "FAILED load_stacks #{stacks}" unless stacks.length == 9 and stacks[0].length == 7
  raise "FAILED bad column #{stacks[2]}" unless stacks[2].join(',') == 'P,Z,B,G,J,T'
end

test_load_stacks

def move_crate(stacks, from, to)
  from_col = stacks[from - 1]
  to_col = stacks[to - 1]
  to_col.append(from_col.pop)
  stacks
end

def test_move_crate
  stacks = load_stacks("day5.txt")
  move_crate(stacks, 6, 1)
  raise "FAILED move_crate" unless stacks[0].length == 8 and stacks[5].length == 2
  raise "FAILED bad column #{stacks[0]}" unless stacks[0].join(',') == 'W,B,D,N,C,F,J,Q'
  raise "FAILED bad column #{stacks[5]}" unless stacks[5].join(',') == 'P,S'
end

test_move_crate

def make_moves(stacks, qty, from, to)
  (1..qty).each do
    stacks = move_crate(stacks, from, to)
  end
end

def test_make_moves
  stacks = load_stacks("day5.txt")
  make_moves(stacks, 8, 7, 4)
  raise "FAILED make_moves #{stacks[6].length}" unless stacks[6].length == 0 and stacks[3].length == 16
end

test_make_moves

def read_move(line)
  if match = line.match(/^move (\d+) from (\d) to (\d)/)
    qty, from, to = match.captures
    return qty.to_i, from.to_i, to.to_i
  end
  return 0, 0, 0
end

def test_read_move
  qty, from, to = read_move("move 22 from 9 to 3")
  raise "FAILED read_move: move #{qty} from #{from} to #{to}" unless qty == 22 and from == 9 and to == 3
  qty, from, to = read_move("1 2 3 3")
  raise "FAILED read_move:" unless qty == 0 and from == 0 and to == 0
end

test_read_move

def stack_tops(stacks)
  tops = Array.new(0)
  stacks.each do |col|
    tops.append(col[col.length - 1])
  end
  tops
end

def test_stack_tops
  stacks = load_stacks("day5.txt")
  tops = stack_tops(stacks)
  raise "FAILED stack_tops [#{tops.join('] [')}]" unless tops.join(',') == "J,T,T,C,S,Q,N,R,R"
end

test_stack_tops

def move_stacks(stacks, qty, from, to)
  if qty > 0
    stacks[to - 1].concat(stacks[from - 1].pop(qty))
  end
  stacks
end

def test_move_stacks
  stacks = load_stacks("day5.txt")
  move_stacks(stacks, 5, 5, 8)
  raise "FAILED expecting 0" unless stacks[4].length == 0
  raise "FAILED P,S,M,F,B,D,L,R,G,V,B,J,S" unless stacks[7].join(',') == 'P,S,M,F,B,D,L,R,G,V,B,J,S'
end

test_move_stacks

def main
  data_file = "day5.txt"
  stacks = load_stacks(data_file)
  IO.foreach(data_file) do |line|
    qty, from, to = read_move(line)
    make_moves(stacks, qty, from, to)
  end
  puts "9000 tops: #{stack_tops(stacks).join}"

  stacks = load_stacks(data_file)
  IO.foreach(data_file) do |line|
    qty, from, to = read_move(line)
    move_stacks(stacks, qty, from, to)
  end
  puts "9001 tops: #{stack_tops(stacks).join}"
end

main

# Why do Ruby if you have Python?