## January 2025 CSE 316
### Online on 8086 Assembly Language

**Subsection:** A2

**Time:** 40 minutes + 5 minutes (submission)

**Problem Description:**

You are given an array of positive integers. Your task is to write an 8086 assembly language program to:

1.  **Input Array Size:** Take the size of the array as input from the user.
2.  **Input Array Elements:** Take the array elements as input from the user. The number of elements must be equal to the size provided.
3.  **Input Search Value:** Take another input from the user, representing the value to search for in the array.
4.  **Output Count:** Print the number of times the search value appears in the array. If the search value does not appear, print 0.

**Assumptions:**

*   All inputs (array size, array elements, and search value) will be single-digit positive integers (1-9).
*   User input is required.

**Examples:**

**Example 1:**

*   **Input:**
    ```
    5
    1 3 5 2 9
    6
    ```
*   **Output:**
    ```
    0
    ```

**Example 2:**

*   **Input:**
    ```
    9
    1 3 5 9 3 7 5 9 2
    5
    ```
*   **Output:**
    ```
    2
    ```