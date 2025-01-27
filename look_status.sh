# 获取容器最后 10 行日志
output=$(docker logs --tail 10 iniverse-contain)

# 检查日志中是否包含 Kh
if echo "$output" | grep -q "Kh"; then
    echo "xxxxx"
else
    echo '停止'
fi
