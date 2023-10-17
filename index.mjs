import * as IPFS from 'ipfs-core';
import fs from 'fs/promises';
import { exit } from 'process';

async function addFile() {
    const fileContent = await fs.readFile('./tree.jpg');
    const ipfs = await IPFS.create();
    const { cid } = await ipfs.add({ path: 'tree.jpg', content: fileContent });
    console.log(cid);
    exit();
}

addFile();
