#include "OBJShaderHeader.hlsli"

VSOutput main(float4 pos : POSITION, float3 normal : NORMAL, float2 uv : TEXCOORD)
{
    //// 右下奥方向
    //float3 lightdir = float3(1, -1, 1);
    //lightdir = normalize(lightdir);
    //// ライトの色
    //float3 lightColor = float3(1, 1, 1);
    //// ピクセルシェーダーみわたす値
    //VSOutput output;
    //output.svpos = mul(mat, pos);
    //// ランバート反射計算
    //output.color.rgb = dot(-lightdir, normal) * m_diffuse * lightColor;
    //output.color.a = m_alpha;
    //output.uv = uv;
    
    VSOutput output;
    
    ////法線にワールド行列を適用
    //float4 wnormal = normalize(mul(world, float4(normal, 0)));
    //float4 wpos = mul(world, pos);
    
    //output.svpos = mul(mul(viewproj, world), pos);
    //float3 eyedir = normalize(campos - wpos.xyz);
    
    ////phong反射
    ////環境反射
    //float3 ambient = m_ambient;
    ////拡散反射
    //float3 diffuse = dot(-lightv, wnormal.xyz) * m_diffuse;
    ////鏡面反射
    //const float3 eye = float3(0, 0, -20);//視点座標
    ////光沢度
    //const float shininess = 4.0f;
    ////反射光ベクトル
    //float3 reflect = normalize(lightv + 2 * dot(-lightv, wnormal.xyz) * wnormal.xyz);
    ////鏡面反射
    //float3 specular = pow(saturate(dot(reflect, eyedir)), shininess) * m_specular;
    
    //output.color.rgb = (ambient + diffuse + specular) * lightcolor;
    //output.color.a = m_alpha;
    
    float4 wnormal = normalize(mul(world, float4(normal, 0)));
    float4 wpos = mul(world, pos);
    
    output.svpos = mul(mul(viewproj, world), pos);
    output.worldpos = wpos;
    output.normal = wnormal.xyz;
    output.uv = uv;
    
    return output;
}