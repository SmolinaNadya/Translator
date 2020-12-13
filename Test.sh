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
test "search -k day -l ru" 0
test "search -l ru" 0
test "update hi -k hello -l en" 0
test "delete -k dia -l pt" 0
test "delete -l en -k hello" 0
test "delete" 3
test "search -l ru -k day" 0
test "update" 5
test "update -l ru" 5
test "update -k night" 5
test "update Привет" 5
test "search -l ru -k song" 1

echo "Tests passed =" $passed 
echo "Tests failed =" $failed

if [ $failed -eq 0 ]; then
  exit 0
else
  exit 1
fi 