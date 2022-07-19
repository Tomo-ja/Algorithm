//
//  Sorting.swift
//  SwiftAGDS
//
//  Created by Tomonao Hashiguchi on 2022-07-18.
//

import Foundation

// Bubble Sort
// Time Complexity: O(n^2)
// Space Complexity: O(n)
func bubbleSort<T: Comparable>(_ arr: [T], _ comparator: (T, T) -> Bool) -> [T] {
  guard arr.count > 1 else { return arr }
  
  var elements = arr
  for i in 0..<elements.count - 1 {
	for j in 1..<elements.count - i {
	  if comparator(elements[j], elements[j - 1]) {
		let temp = elements[j - 1]
		elements[j - 1] = elements[j]
		elements[j] = temp
	  }
	}
  }
  return elements
}

// Selection Sort
// Time Complexity: O(n^2)
// Space Complexity: O(n)
func selectionSort<T: Comparable>(_ arr: [T], _ comparator: (T, T) -> Bool) -> [T] {
  guard arr.count > 1 else { return arr }
  var elements = arr
  for i in 0..<elements.count - 1 {
	var indexMin = i
	for j in i+1..<elements.count {
	  if comparator(elements[j], elements[indexMin]) {
		indexMin = j
	  }
	}
	if i != indexMin {
	  elements.swapAt(indexMin, i)
	}
  }
  return elements
}


// Insertion Sort
// Time Complexity: O(n^2)
// Space Complexity: O(n)
func insertionSort<T: Comparable>(_ arr: [T], _ comparator: (T, T) -> Bool) -> [T] {
  guard arr.count > 1 else { return arr }
  
  var elements = arr
  for i in 1..<elements.count {
	var j = i
	let toInsert = elements[j]
	while j > 0 && comparator(toInsert, elements[j - 1]) {
	  // shift
	  elements[j] = elements[j - 1]
	  j -= 1
	}
	elements[j] = toInsert
  }
  
  return elements
}


// Merge Sort (Divide and Conquer)
// Time Complexity: O(N lgN)
func mergeSort<T: Comparable>(_ arr: [T], _ comparator: (T, T) -> Bool) -> [T] {
  guard arr.count > 1 else { return arr }
  let mid = arr.count / 2
  let sortedLeft = mergeSort(Array(arr[..<mid]), comparator)
  let sortedRight = mergeSort(Array(arr[mid...]), comparator)
  return merge(sortedLeft, sortedRight, comparator)
}

// O(N)
func merge<T: Comparable>(_ left: [T], _ right: [T], _ comparator: (T, T) -> Bool) -> [T] {
  var i = 0
  var j = 0
  var merged: [T] = []
  while true {
	guard i < left.count else {
	  merged.append(contentsOf: right[j...])
	  break
	}
	guard j < right.count else {
	  merged.append(contentsOf: left[i...])
	  break
	}
	if comparator(left[i], right[j]) {
	  merged.append(left[i])
	  i += 1
	} else {
	  merged.append(right[j])
	  j += 1
	}
  }
  
  return merged
}


// * Quick Sort (Does not sort in-place)
// Space Complexity: O(n) -> Your implementation should be O(1) (which means you're not supposed to create new arrays)
func quickSortSlow<T: Comparable>(_ arr: [T]) -> [T] {
  if arr.count <= 1 { return arr }
  var elements = arr
  let pivot = elements.removeLast()
  let lessOrEqual = elements.filter { $0 <= pivot }
  let greater = elements.filter { $0 > pivot }
  return quickSortSlow(lessOrEqual) + [pivot] + quickSortSlow(greater)
}

// * Quick Sort (sorts in-place)
// Time Complexity: O(N lgN) -> technically O(N^2) in the worst case
// Space Complexity: O(1)
func quickSort<T: Comparable>(_ arr: inout [T], _ start: Int, _ end: Int) {
	if start >= end { return }

	let pivotIndex = partition(&arr, start, end)
	quickSort(&arr, start, pivotIndex - 1)
	quickSort(&arr, pivotIndex + 1, end)
}

/// Returns the index of the pivot
/// - Parameters:
///   - arr: the array
///   - start: the start index
///   - end: the end index
/// - Returns: the index of the pivot after partitioning
func partition<T: Comparable>(_ arr: inout [T], _ start: Int, _ end: Int) -> Int {

	var leftPoint = start
	var rightPoint = end
	var isUnsortGroupLeft = true
	let pivot = arr[rightPoint]
	
	while leftPoint < rightPoint {
		if isUnsortGroupLeft {
			if arr[leftPoint] > pivot {
				switchPosition(&arr, leftPoint, rightPoint)
				rightPoint -= 1
				isUnsortGroupLeft = false
			} else {
				leftPoint += 1
			}
		} else {
			if arr[rightPoint] < pivot {
				switchPosition(&arr, rightPoint, leftPoint)
				leftPoint += 1
				isUnsortGroupLeft = true
			} else {
				rightPoint -= 1
			}
		}
	}
	return rightPoint
}

func switchPosition<T: Comparable> (_ arr: inout [T], _ index1: Int, _ index2: Int) {
	let temp = arr[index2]
	arr[index2] = arr[index1]
	arr[index1] = temp
}
