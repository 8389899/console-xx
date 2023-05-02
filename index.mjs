const { exec } = require('child_process');

exec('/start.sh', (error, stdout, stderr) => {
  if (error) {
    console.error(`执行脚本时出错: ${error}`);
    return;
  }
  console.log(`输出: ${stdout}`);
  console.error(`错误: ${stderr}`);
});
