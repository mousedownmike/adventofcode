--filename = "day4_test.txt"
filename = "day4.txt"

function isContained (lMin, lMax, rMin, rMax)
    return (lMin <= rMin and lMax >= rMax) or (rMin <= lMin and rMax >= lMax)
end
function overlapping (lMin, lMax, rMin, rMax)
    return (lMin <= rMin and lMax >= rMin) or (rMin <= lMin and rMax >= lMin)
end

--print(isContained("8","19","25","85"))

contained = 0
for line in io.lines(filename) do
    for lMin, lMax, rMin, rMax in string.gmatch(line, "(%d+)-(%d+),(%d+)-(%d+)") do
        if isContained(tonumber(lMin), tonumber(lMax), tonumber(rMin), tonumber(rMax)) then
            contained = contained + 1
            --print(line)
        end
    end
end
print("contained:" .. contained)


overlaps = 0
for line in io.lines(filename) do
    for lMin, lMax, rMin, rMax in string.gmatch(line, "(%d+)-(%d+),(%d+)-(%d+)") do
        if overlapping(tonumber(lMin), tonumber(lMax), tonumber(rMin), tonumber(rMax)) then
            overlaps = overlaps + 1
            print(line)
        end
    end
end
print("overlaps:" .. overlaps)
