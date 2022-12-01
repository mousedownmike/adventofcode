package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
)

func main() {
	filename := "day1/input.txt"

	file, err := os.Open(filename)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	elfCals := []int{0}
	for scanner.Scan() {
		row := scanner.Text()
		if row != "" {
			cals, _ := strconv.Atoi(row)
			elfCals[len(elfCals)-1] += cals
		} else {
			elfCals = append(elfCals, 0)
		}
	}

	if scanner.Err() != nil {
		log.Println(scanner.Err())
		// Return so that the file is closed.
		return
	}

	sort.Ints(elfCals)

	fmt.Println("Top Cals:", elfCals[len(elfCals)-1])

	top3 := 0
	for _, cal := range elfCals[len(elfCals)-3 : len(elfCals)] {
		top3 += cal
	}

	fmt.Println("Top 3 Cals:", top3)

	//maxCals := 0
	//maxElf := -1
	//
	//for elf, cals := range elfCals {
	//	if cals > maxCals {
	//		maxCals = cals
	//		maxElf = elf + 1
	//	}
	//}
	//
	//fmt.Println("Elf", maxElf, "has", maxCals, "calories")

}
