package disk

import (
	"testing"
)

func testNil(t *testing.T, err error) {
	if err != nil {
		t.Errorf("Not nil error")
	}
}

func testEqual(t *testing.T, expected interface{}, actual interface{}) {
	if actual != expected {
		t.Errorf("Mismatched values")
	}
}

func newTestDisk() Disk {
	return &disk{}
}

func TestFullCircle(t *testing.T) {
	d := newTestDisk()
	// bytes, err := f.ReadCompleteFileFromDisk("./testutils/testFile.md")

	err := d.WriteCompleteFile("./test.md", []byte("ThisIsTestDataBeingWritten"), 0644)
	testNil(t, err)

	bytes, err := d.ReadCompleteFile("./test.md")
	testNil(t, err)
	testEqual(t, "ThisIsTestDataBeingWritten", string(bytes))

	err = d.DeleteFile("./test.md")
	testNil(t, err)

	bytes, err = d.ReadCompleteFile("./test.md")
	testEqual(t, "open ./test.md: no such file or directory", err.Error())
}
