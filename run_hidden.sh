#!/bin/bash

set -u

TARGET_DIR="${1:-../assignment-template}"

PASS_COUNT=0
FAIL_COUNT=0

normalize() {
    sed 's/[[:space:]]*$//'
}

run_test() {
    local q="$1"
    local input_file="$2"

    local output_file="${input_file%.in}.out"
    local exe="${TARGET_DIR}/${q}/main"

    local test_name
    test_name=$(basename "$input_file" .in)

    echo "========================================"
    echo "[HIDDEN][$q] Test: $test_name"
    echo "----------------------------------------"

    if [ ! -x "$exe" ]; then
        echo "ERROR: executable not found:"
        echo "  $exe"
        echo
        echo "Run in assignment-template:"
        echo "  make build"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return
    fi

    if [ ! -f "$output_file" ]; then
        echo "ERROR: expected output file not found:"
        echo "  $output_file"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return
    fi

    actual=$(mktemp)

    "$exe" < "$input_file" | normalize > "$actual"
    normalize < "$output_file" > "${actual}.expected"

    if diff -u "${actual}.expected" "$actual" > /dev/null; then
        echo "PASS"
        PASS_COUNT=$((PASS_COUNT + 1))
    else
        echo "FAIL"
        echo

        echo "Input:"
        cat "$input_file"

        echo
        echo "Expected:"
        cat "${actual}.expected"

        echo
        echo "Got:"
        cat "$actual"

        echo
        echo "Diff:"
        diff -u "${actual}.expected" "$actual" || true

        FAIL_COUNT=$((FAIL_COUNT + 1))
    fi

    rm -f "$actual" "${actual}.expected"

    echo
}

if [ ! -d "$TARGET_DIR" ]; then
    echo "ERROR: target directory not found:"
    echo "  $TARGET_DIR"
    exit 1
fi

for q in q1 q2 q3 q4
do
    if [ ! -d "$q" ]; then
        continue
    fi

    for input_file in "$q"/*.in
    do
        if [ -f "$input_file" ]; then
            run_test "$q" "$input_file"
        fi
    done
done

echo "========================================"
echo "Hidden Test Summary"
echo "----------------------------------------"
echo "PASS: $PASS_COUNT"
echo "FAIL: $FAIL_COUNT"

if [ "$FAIL_COUNT" -eq 0 ]; then
    echo
    echo "All hidden tests passed!"
    exit 0
else
    echo
    echo "Some hidden tests failed."
    exit 1
fi