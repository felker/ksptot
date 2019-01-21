/*
 * _coder_getStatefromKepler_Alg_info.c
 *
 * Code generation for function '_coder_getStatefromKepler_Alg_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "getStatefromKepler_Alg.h"
#include "_coder_getStatefromKepler_Alg_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 7);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString(
    "getStatefromKepler_Alg"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(7.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (2.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[33] = {
    "789ced5ddb6f2b4719dfb6e7f422d4720a94520a9ca6a0a342a5f89a38690bf56d633b89efcec53ead92b5bdb637d99b77d797e4018c78a0e2a98f20f170fa04"
    "bcf511f5291248fd072812a8528f1052e10109f180847880b5d793d8391eef263b5e7b376329daccf9e2f9667ee79bdfcc7cdfccb7c46389e46304413ca7fefc",
    "ed4704d18df44b04f1ecb07c87d03e8f13e39fcbf2c786cfd591725f0e3eb7895b83f2b323f2cfd5f22f87e58ac02b7457d10a2cc3d3a91657a625b5c0531c7d"
    "5e4d55e0189ee295c2894813122d0b6c9bae0e243586a50b0c476f0b238538a316b88d11d179a12feaff1e69d095e37c8b23a4867cd15c76b4408ce0f35b48ff",
    "6f19c4670f82cf9d6119c8ef93efba1a0247bba82ac5b98e65511114f0a80855ba4ef32e8eeebaeab492572885ae4902b7458b2c2d1d84d83ae49f97b98bff67"
    "483b9f34d88f2720fd786658feda582d6f06b5a777f87c2508da7108d163144f583beea8927e992a6bff91a8f43d39521ed7f7e4a05c155a6596bed0f76b93fa",
    "42507d5a19c8ef27b6f7559369c9928b152a14eb4a860adba1b02be7757b02659722086c59e8ba688e75b14cd9c5510a4b955d345b6bf12e1523d53208433819"
    "b58fd1e7b87d3c3d2cf7a2c57b9f84acd36775ffe6ab0f36be8ddadd5721fa80dd0179b35caed6fc62395dc8e4a5ace089c5d86d7ff8a21d191d3d7aed2046ca",
    "93fa39ebfaf1f89d666f173cde3389d35d1d9c80bc3ff749cb8cba5890788a5d66e4708b619504af2e176889a9cc8de7cdae0b723afd07f22bd849ffe7f5015e"
    "aed70160aecb8001c3b190f7dffccf9f31efdb9df7d3ed6624548bb7d70a59ff4985e478ef46898d63debf19bcef46c6fb2fe9e004e497785f56a1a2a465b0ba",
    "37bfbebffc81b5077c80be0f4df63fa9a30fc8cdf2feeb1a62e7366321dfbff0d91b98efedcef7472bb16cbd9add4dac6fa43cebbbe5ec4abd968960bebf697c"
    "ff9e499c5ed5c109c82ff13d258aec497e40611b2dbea230023f8e8368b25d5fd4691790d786da0f1a145f553700a8d6ff3b3afa81dcec3c3001488be703e2bf",
    "cf05fe88e78319e9b36a3e0865ea0aefefae14c4aa984b6c67a552aa1470d07c80c7f3a34fb8fdc51db71fb8ae1f08ef0726b71fef079cc5ff4edf0f3825ce7b"
    "0869275afb7b1b593c578f6f3951e8f48f05d8359e1b86ead3ca407ebd7da220ca2e0da139f8f5fff79e17afebedceeb4d7e3d95cf09c24927b316a33c253e2a",
    "9469d239bc6ed7f10bf36f18b5b7c747cae3f636fef7dac71bd49ee8fcfc77757003721cdfc5f1ddabe9b3ba7ff3d587e3bb68eab7eb3c700869d7a2aee79f86"
    "e2a4e96364b5cb12d3b5eb7a7e03aa4f2b03f975e33eea2f2e8051df162cb4831ffe0bf3b8ed79bcad54921223ec702bde53fe78777bbd93dc8f6f601ebf193c",
    "1e45c6e3b7a138ddd6f6279a5bc6b67e9910549f5606f2ebdbc1981958b91ebff3a755ec97b13b8fef3576e9d57c36bf922b645bfbd1add2ae90df7190bfddae"
    "e3d75abfccbda0f67c15fb658672ec9779f4099907b05f6686fab05f064dfd1f42be6f14c74d48fd004720373d0f2cd558052c7a098bedae970ca2b2bb1775f0",
    "02f289e76dc8ba6dcfd9ccc04e26f23e006a0e7cbff4c1a798efedcef7ee5427c01518aeb4c5e4aae456b492afd54e1c74bf168fe3c9ed87f13d6cbf6114af67"
    "75f0027246e6b585aad2cfb461dff394099dfe02f915d70335a64b574541350fd71852f3b89fe1b9ff12e679bbf37ccc777c926fd6193652881ce79ae17ae178",
    "878c629ebfa93c0fd3872eee5a63d44d4dc3aefefa28549f56067233bcae21a45902e67367e833cbe72f40f401bb03f2769326c576455edfeff8042123e73dbe"
    "6289700e9fdbc5ef7ac1e74b354692951a33de8f43483b91dadfd921327ffdb774700372158c031584839a20b182201e086d5aaab142e7a0d2cf7737bf7c0967",
    "26fb5fd2d107e4d73c6fa399d114e4e6e0c709fefd368edf2eea7c60747d2f6f915d327a7a9ad9ec7afd49af3b920d79dc0e3a57ff10f27da338f620f5031c81"
    "7c76e37a69fa1f1c346856a4256bed34866c3f706ba43c8eefadf3fd40bf3ce7b802c357e96e8257cedbf1c0643b823aed007273fb8465ce42bb780bc771ed3f",
    "1fe44f44865b69e6f63c4cb9ea4f94b299a4a7ed207fcf03c8f76ff0b82546ef53d9dd8faf379f541ad420328efdf88f3e21f681fd3e33d487fdf868ea7f08f9"
    "3e5ee79bb1d38465f913d48e7354777ef3c082fafdc7ef5b0d30b2daefdf7bebe567b09fc7eefc2f35dde21123fb43dc6a26c067cafbbead5dd941e7751e42be",
    "8ff9df849df6ace57f86c7fcafc7ff0c6f39ffbf8df9dffefc5fa78a81b46f2fd50c94434a64854afb697f36e61cfec771df479f50fb7b78888cd7afeabf37ab"
    "efaae7791e98d41784ead3ca406e237f1ff6d3cf501ff6d3a3a9dfac5ff646dcb7222ece659acd7fff9a0e5e403e29ff7d98e129e952b26754f104b3f9efcf4c",
    "eabfafa31fc891e4cb9e04e4d0e36fe17aff1fcfe33cf8b69f1f4e694a08f1295f49a9d7bd3177325dddd9f338687e30bbde2f40ea073802b9f9f9415bf11fd4"
    "5881520ece670a6bcf7996f0bd5c93fa9c7fcf03dfcb9da53e7c2f174dfd66793f0ba91fe008e4e6799f179414954a4b097568d7c1f6c0e27b5b7bc8fc3c7a79",
    "d61899a77803fd5bd47b5b11a83ead0ce4e6f265aa1859bf9ec7fe9e19eab3eade5633d44a73fe937dbf3b27795b110fbddee6528473781d8fdf69f6f61d64f7"
    "b4eeeae004e438af1aceab76357d56f76fbefa705e3534f5e3f5fca34f23ebf99e49dc5ed6c10dc827bfcfb0c60a8264a8ff8beacf49ebf41fc851bdcf708098",
    "a5ef3feb2de373fbf6e7ff726335b3cfb34a352f70648b8ffbca6478d341e77616d02fbb7871de5e0a99fffe2b3a7801f925dea725493014b798d5f9cc055bf7"
    "cb6af3e8aa4b63fb21e75fa6fe01667358f7fff4937b387e6b77dee70bc52ce52dc64bbe76bb45eeb73d3e6e9371505e7da7bcc7f67d483b8dda1f6cdd0bf2ec",
    "bbc76a218383472faa3d89e1b3171e3e83c37f0f22f3fb3f0169df1d5532e069417bb3b95dfdfe21a83ead0ce4d7f51bd65abc6a67f23ceeed92c57b78fd6ff7"
    "79402c748f026925b31a485385fc51418a9d547807c573f1f89d666fe8fcfe2fe9e004e493fd3d80e5e7979fcdec3e31a9a30fc851f97b80cd58682f1ffde237",
    "98efedcef76bd2b64c652bc9e25eb9b85f0e8757fdb53a8df9fec6f13d6c5f6114a7efeae004e493cef38f1f404ff01996aad097f0104db66fdee7fadfd1d10f"
    "e448cef54f04d4f2fccd1fbfb782fd42769f1fb637b72ac566663d544cfa25d92b32de7660d341e7facf20dfc7e37a9a1d2e3b6e9f705d7f10de274c6e3fde27",
    "386b1e70fa3ec129f1811ea49d46ed0f162705f18157462b01710062f89c413c40effd2d9c5465da4c95b66b3c60b6797cfae7090042cb832d94853ce5f9ec5d"
    "47afff57e679dec9aa7b00dd62a944d6438cd4f4b73972a5500c658f28c239bc8fc7ef347bfbe7dba878f529284e4f0dcac34eda36ae3bdbfb207d3b0066a079",
    "0a2d3cdfe3ba9bc5eb77bbf3f85a275bdbd9f7af06e26d36b71e5d5bdb16762a04e6f1798f5f985fdba8bd3d0e69f73397fe5efbdc0b6acf57f1fd2e02cdbe0f"
    "dfef72262f5bad0fdfef4253bf5de7814348bbd0dadbf790f1fe2b3a3801f904bf3ddd15230227520aa332b15d793fafd37f2047919f670c30ebede62f1f7fd9",
    "d17e9cb9eab38af71b55512aed9f92957a20ba1d38f1b5a85076cd41fe7bccfbd3eced0d64f7b9bea48313905fe27db5ef84a17e2faa7f87d4e937909be57b15"
    "28abe3b398df67a8cfb27cfbe1f04935e023c952d7db8e6f15986851ca39685def94f82c2c6fb251fb83e54503fe9ed788d10fe4fed648bcd6aa7b5b72ff652b",
    "847df93f04d5a79581dccc396019bc6cc5004ef8de963df459c5ff14150f973ac77166371969b1e1301f0d64520e3aa789c7ef347b5b947b5b80e5f1bd2da3e7"
    "3181cd58e8c7ff3d3e8f697fbe77afc457d7229d3daf3bdce9b06e91f547eba7d89f73e3f8fe7d9338e17b5bd3f5dfc0fb1df8ded60cf5e17b5b68ea3f837c1f",
    "8feb6976b828f7b6d0ed13aeeb0fc2fb84c9edc7fb0467cd034edf2738252e005b27cfe41ce8c8bd2d54fcab975f536e4a4abf6c57ff7f18aa4f2b03b9a9fda4"
    "8a91f5e73ab1ff7f96faace2797f8cac35dcab89a334e94b28992ccfb7235107c57ff1f89d666ff790adebbfa18313903f729e3f2a7014c39397f336cfdbff63",
    "769d6f55defe31002dcddb4f2cfd358cfd3d8bcaff46ef77b1c96499f4f8222b1da6522165b1dd28d6b708e7f03f1ec793db3f6e77ab96e55d606459a424d9b6"
    "7917e2507d5a19c8afb71ee863d35f11009496390bfd36dfaeff1bafe71795cf8daee757d85cbc2324d762be9d783d50899c6ee6127907f96df07a7e9abdbd86",
    "ecbc3e7effcae47ee3f7afd8937fadd687dfbf82a67eccf7d3ec0d5d5cf6eb3a380139242e3bf4d2dbf7fc664a471f90238bcb0e6dc642be7ff3f3cff1fa7e51"
    "f9de703e9ed676debdeb4b87a4848fe4f73773ab7c6e95c07c7fd3f8fe7d9338e1f39bd3f5dfc0735ef8fce60cf5e1f39b68ea3f837c1f8feb9bb54fb8aeff1f",
    "ef1326b71fef13ec310fe07d8256c6e737b5cfd5ce6f6e04b55f3690c5099ed7c111c855923be01486a3e58306cd8ae0f5f4b6f5172575f401f9f5f33e3d8298"
    "d5f97dbe8ff3762eee3c60743f502d9d50fe7285da8ffaa9d0a94016b8a3a2b8e19c79e00cf27da338de87d40f700472a4e378a922709cc01f541a74e578fcbd",
    "e496ce0744213878f4f2c8f6077775f004729cd719e775be9a3eabfb375f7d38af339afaedbeceb3767f90096acf2d64fb831775f003f289fe22b26e5b3fd1a6"
    "4ebf811c459ee73e5073e0ffa50f3ec5fc6f77fe77a73a01aec070a52d265725b7a2957cad76e2a0f3a276e7ff4348fbd0da5d76def91dca2c252f77eb3437a4",
    "b1b99d1f5d407b991c1fe823e61a2066757e879ffcec07384ebca8bc6f343ee0f3754e378e956ac8cb6e55b2f1001f3b492b04e6fd9b338ed54f6f73de71e101"
    "ef333ccbf0c30344768d075816171ed88b8698b57161e2a32ffcf80f98f767a4cfaaf57eb84c85e470ca9f69b36b595e51d6f68e9bcd18e6fd1bc5fb4472defe",
    "fe01efb764fa40a26bfddfe7c6fb76799f97662f238859ff3e20ccff33d46715ff4ba1a43f1faa45d21552968fa8dd44633dca39e8bed819e4fb46717c17523f"
    "c011c891f2ff52996685ce81d29068b921b055c26a3b7c07d97cf04d1dfc807cd27c7095fe2feafde1ac4eff811c8dfd9c23368f7ce29fc57f87fdff769f0f92",
    "d5ddf5746aad15dbd8aca69a423ab3133df591ce990fecbe1f1021ed9b49fc37980d0e9ebd0c8eff9ad487e3bfa8f559ddbff9eac3f15f34f5db9dff0f21ed43"
    "1b0748235bff5f330f28706a9c8780ed1affcd8c9427f51fc84ddbcb1031603216f2feaf7e7e8c79dfeebc5fa3c39d7541f4ec37b3a2b296e71a9d8d50c7017e",
    "a0ff030cd5c860", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 82832U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_getStatefromKepler_Alg_info.c) */
