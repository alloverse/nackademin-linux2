<pre>
<?php
$conn = new mysqli("localhost", "dbuser1", "losen1", "testdb1");

if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}
$sql = "select * from users";
$result = $conn->query($sql);
while($row = $result->fetch_assoc()) {
	print_r($row);
}
?>
</pre>
