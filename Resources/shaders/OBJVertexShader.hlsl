#include "OBJShaderHeader.hlsli"

VSOutput main(float4 pos : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD)
{
    //右下奥方向
    float3 lightdir = float3(1, -1, 1);
    lightdir = normalize(lightdir);
    //ライトの色
    float3 lightColor = float3(1, 1, 1);
    //ピクセルシェーダーみわたす値
    VSOutput output;
    output.svpos = mul(mat, pos);
    //ランバート反射計算
    //output.color.rgb = dot(-lightdir, normal) * m_diffuse * lightColor;
    //output.color.a = m_alpha;
    //output.uv = uv;
    
    //phong反射
    //環境反射
    float3 ambient = m_ambient;
    //拡散反射
    float3 diffuse = dot(-lightdir, normal) * m_diffuse;
    //鏡面反射
    const float3 eye = float3(0, 0, -20);//視点座標
    //光沢度
    const float shininess = 4.0f;
    //頂点から視線への方向ベクトル
    float3 eyedir = normalize(eye - pos.xyz);
    //反射光ベクトル
    float3 reflect = normalize(lightdir + 2 * dot(-lightdir, normal) * normal);
    //鏡面反射
    float3 specular = pow(saturate(dot(reflect, eyedir)), shininess) * m_specular;
    
    output.color.rgb = (ambient + diffuse + specular) * lightColor;
    output.color.a = m_alpha;
    
    return output;
}