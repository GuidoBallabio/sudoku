nums = [c for c in "123456789"]

function possible_solutions(grid)
    grid = map(grid) do c
        if c == ' '
            nums
        else
            [c]
        end
    end           
end

function constraint1step(grid)
    grid = copy(grid)
    for s in squares 
        values = grid[s]
        len = length(values)

        if len == 1 # if square has only a value, the peers remove it
            grid[peers[s]] = map(grid[peers[s]]) do set
                setdiff(set, values)
            end
        elseif len == 0 # if square has zero values is inconsistent
            return grid, false    
        end

        for u in units[s] # if unit has only one place for value assign it
            for c in nums
                cs = [s for s in u if c in grid[s]]
                n_places = length(cs)
                if n_places == 1
                    grid[cs[1]] = [c]
                elseif n_places == 0 # if zero inconsistent
                    grid, false
                end
            end
        end
    end
    grid, true
end

function constraint(grid)
    grid, valid = constraint1step(grid)
    if !valid || all(map(length, grid) .== 1)
        return grid, valid
    end

    next_grid, next_valid = constraint1step(grid)

    if all(grid .== next_grid) && next_valid # fixed-pont
        return grid, true
    end

    if !valid || all(map(length, grid) .== 1)
        return grid, valid
    end

    constraint(next_grid)
end

function search((grid, valid))
    if !valid || all(map(length, grid) .== 1)
        return grid, valid
    end
    
     #minimum remaining values
    _, s = minimum([(length(grid[s]), s) for s in squares if length(grid[s]) >1])
    
    res1step = map(grid[s]) do v
        tmp = copy(grid)
        tmp[s] = [v]
        constraint(tmp)
    end
    resNstep = search.(res1step)

    reduce(resNstep, init=(grid, false)) do res1, res2
        if res1[2]
            res1
        else
            res2
        end
    end
        
end

function solve(grid)
    grid = possible_solutions(copy(grid))
    grid, valid = constraint(grid)

    search((grid, valid))
end

function check_sol((grid, valid))
    if valid
        getindex.(grid, 1)
    else
        grid, valid
    end
end