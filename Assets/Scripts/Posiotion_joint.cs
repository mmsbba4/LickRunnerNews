using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Posiotion_joint : MonoBehaviour
{
    public Transform target_position;
    void Update()
    {
        transform.position = target_position.position;
    }
}
