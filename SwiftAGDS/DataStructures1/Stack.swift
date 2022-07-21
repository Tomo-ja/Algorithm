//
//  Stack.swift
//  SwiftAGDS
//
//  Created by Tomonao Hashiguchi on 2022-07-20.
//

import Foundation


/// The Stack class represents a last-in-first-out (LIFO) stack of generic items.
/// It supports the usual *push* and *pop* operations, along with methods for peeking at the top item, testing if the stack is empty, and iterating through the items in LIFO order.
/// This implementation uses a singly linked list with an inner class for linked list nodes.
public final class Stack<E> : Sequence {
  
	private var topOfStack : Node<E>? = nil
	
	///number of items in stack
	private(set) var count: Int = 0
	
	fileprivate class Node<E> {
		fileprivate var item: E
		fileprivate var oneBelow: Node<E>?
		
		fileprivate init(item: E, oneBelow: Node<E>?){
			self.item = item
			self.oneBelow = oneBelow
		}
	}
	
	public init(){}
	
	///add an item
	public func push(_ item: E) {
		let oldTop = topOfStack
		topOfStack = Node<E>(item: item, oneBelow: oldTop)
		count += 1
	}
	
	///removes and returns the item most recently added to the stack
	public func pop() -> E? {
		guard let oldTop = topOfStack else {return nil}
		
		topOfStack = oldTop.oneBelow
		count -= 1
		
		return oldTop.item
	}
	
	///returns (but does not remove) the item most recently added to the stack.
	public func peek() -> E? {
		return topOfStack?.item
	}
	
	///Is the stack empty?
	public func isEmpty() -> Bool{
		return topOfStack == nil
	}
	
	public struct StackIterator<E> : IteratorProtocol {
	  private var current: Node<E>?
	  
	  fileprivate init(_ topOfStack: Node<E>?) {
		self.current = topOfStack
	  }
	  
	  /// BagIterator that iterates over the items in this bag in arbitrary order. (reverse order)
	  public mutating func next() -> E? {
		if let item = current?.item {
			current = current?.oneBelow
			return item
		}
		return nil
	  }
	}
	
	/// Returns an iterator that iterates over the items in this stack in reverse order.
	public func makeIterator() -> StackIterator<E> {
		return StackIterator(topOfStack)
	}
}
