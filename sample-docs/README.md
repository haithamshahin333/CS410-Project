Generating Sample Data and Uploading Steps:

Folder: vm-sample-data

    1) Pull down example PDF document from the following [link](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)

    2) Generated READMEs that add specific "enterprise" steps to the VM creation

    3) Upload to Azure Storage

Importing Data:

    1) Based on the following [doc](https://learn.microsoft.com/en-us/azure/search/search-howto-indexing-azure-blob-storage#supported-document-formats), the azure blob indexer only can extract text from the noted file types which does not include a markdown file. Thus, it is necessary to convert these prior to upload so they can be indexed.