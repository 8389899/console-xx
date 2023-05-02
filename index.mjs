const { exec } = require('child_process');

exec('sh /start.sh', (error, stdout, stderr) => {
  if (error) {
    console.error(`执行Shell脚本时出错：${error}`);
    return;
  }
  console.log(`脚本的输出：${stdout}`);
});
