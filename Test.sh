passed=0 
failed=0 

function test() {
  test_name=$1
  expectedCode=$2
  ./.build/debug/App ""${test_name}""
  exitCode="$?"
  if [ "$exitCode" == "$expectedCode" ]; then 
  echo "Test $test_name passed: exit code - $exitCode." 
  let passed++ 
  else 
  echo "Test $test_name failed: received - $exitCode expected - $expectedCode ." 
  let failed++ 
  fi 
}

test "search" 0
test "search -k day" 0
test "search -k home -l ru" 0
test "search -l ru" 0
test "update hi -k hello -l en" 0
test "delete -k dia -l pt" 0
test "delete -l en -k hello" 0
test "delete" 3
test "search -l ru -k day" 0
test "update" 1
test "update -l ru" 1
test "update -k night" 1
test "update Привет" 1
test "search -l ru -k song" 2

echo "Tests passed =" $passed 
echo "Tests failed =" $failed