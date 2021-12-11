using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick
{
    public class SingleCake : MonoBehaviour
    {
        public void Active()
        {
            GetComponent<MeshRenderer>().enabled = false;
        }
    }

}
