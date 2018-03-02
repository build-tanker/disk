package disk

import (
	"io/ioutil"
	"os"
)

// Disk - interface for os and io/ioutil
type Disk interface {
	ReadCompleteFile(path string) ([]byte, error)
	WriteCompleteFile(path string, data []byte, permissions os.FileMode) error
	DeleteFile(path string) error
}

type disk struct {
}

// NewDisk - create a new disk to interface os and io/ioutil
func NewDisk() Disk {
	return &disk{}
}

func (d *disk) ReadCompleteFile(path string) ([]byte, error) {
	return ioutil.ReadFile(path)
}

func (d *disk) WriteCompleteFile(path string, data []byte, permissions os.FileMode) error {
	return ioutil.WriteFile(path, data, permissions)
}

func (d *disk) DeleteFile(path string) error {
	return os.Remove(path)
}
